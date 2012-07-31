class UsersController < ApplicationController
  before_filter :require_no_logined, :except => [:destroy]
  before_filter :require_logined, :only => [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new params[:user]
    if @user.save
      login_as @user
      redirect_to posts_path
    else
      render :new
    end
  end

  def login
  end

  def act_login
    login = /^#{params[:login]}$/i
    user = User.any_of({:login => login}, {:email => login}).first
    if user and user.authenticate(params[:password])
      login_as user
      redirect_to posts_url
    else
      flash[:error] = t('users.login_error')
      redirect_to login_url
    end
  end

  def destroy
    logout
    redirect_to posts_path
  end
end