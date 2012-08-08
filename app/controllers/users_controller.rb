class UsersController < ApplicationController
  before_filter :require_no_logined, :except => [:destroy, :index]
  before_filter :require_logined, :only => [:destroy]
  before_filter :require_admin, :only => [:index]

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

  def index
    @users = User.active.page params[:page]
  end
end