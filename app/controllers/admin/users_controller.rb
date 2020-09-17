class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :user_admin?, only: [:index, :show, :edit]
  def index
    # @user = User.select(:id, :name, :admin, :email).order("id ASC").page(params[:page]).per(10)
    @user = User.all.includes(:tasks).order("id ASC").page(params[:page]).per(10)
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
    @task = @user.tasks.select(:id, :title, :priority, :state, :created_at, :deadline).order("created_at ASC").page(params[:page]).per(5)
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
      redirect_to admin_users_path, notice: t(".DestroyUser")
    else
      redirect_to admin_users_path, notice: t(".NotDestroyUser")
    end
  end
  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
end
