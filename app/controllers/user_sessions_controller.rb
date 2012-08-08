class UserSessionsController < ApplicationController
  def new
  end

  def create
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
