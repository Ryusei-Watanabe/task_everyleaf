class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_user,only: [:new]
  before_action :check_user, only: [:show]
  before_action :logged_user_session_new, only: [:new, :create]

  def new
  @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
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
      redirect_to @user, notice: t(".EditUser")
    else
      render :edit
    end
  end
  def destroy
    if @user.destroy
      redirect_to  new_user_path, notice: t(".DestroyUser")
    else
      redirect_to tasks_path, notice: t(".NotDestroyUser")
    end
    # @user.destroy
    # redirect_to root_url, notice: 'Account was successfully destroyed.'
  end
  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  def check_user
    # idを渡してる
    if @user.id != current_user.id
      redirect_to tasks_path
    end
  end
end
