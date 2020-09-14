class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_user,only: [:new]
  def index
    @user = User.all.order("created_at ASC")
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to admin_user_path(@user.id)
    else
      render :new
    end
  end
  def show
  end
  def edit
  end
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'user was successfully updated.'
    else
      render :edit
    end
  end
  def destroy
    @user.destroy
    redirect_to root_url, notice: 'Account was successfully destroyed.'
  end
  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
end
