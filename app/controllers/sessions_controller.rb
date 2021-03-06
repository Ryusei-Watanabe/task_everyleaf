class SessionsController < ApplicationController
  before_action :logged_user,only: [:new]
  before_action :logged_user_session_new, only: [:new, :create]
def new
end
def create
  user = User.find_by(email: params[:session][:email].downcase)
  if user && user.authenticate(params[:session][:password])
    session[:user_id] = user.id
    redirect_to user_path(user.id)
  else
    flash.now[:danger] = 'ログインに失敗しました'
    render :new
  end
end
def destroy
  session.delete(:user_id)
  flash[:notice] = 'ログアウトしました'
  redirect_to new_session_path
end
end
