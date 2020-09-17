class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user
  before_action :check_user, only: [:edit, :destroy]
  def index
    # @tasks = Task.all
    # @tasks = @tasks.joins(:labels).where(labels: { id: params[:label_id] }) if params[:label_id].present?
    if params[:sort_expired] == "true"
      @task = current_user.tasks.deadline_sort.page(params[:page]).per(5)
    elsif params[:priority_high] == "true"
      @task = current_user.tasks.priority_sort.page(params[:page]).per(5)
    elsif params[:task].present?
      if params[:task][:title].present? && params[:task][:state].present?
        @task = current_user.tasks.title_search(params[:task][:title]).state_search(params[:task][:state]).created_at_sort.page(params[:page]).per(5)
      elsif params[:task][:title].present?
        @task = current_user.tasks.title_search(params[:task][:title]).created_at_sort.page(params[:page]).per(5)
      elsif params[:task][:state].present?
        @task = current_user.tasks.state_search(params[:task][:state]).created_at_sort.page(params[:page]).per(5)
      else
        @task = current_user.tasks.created_at_sort.page(params[:page]).per(5)
      end
    else
      @task = current_user.tasks.created_at_sort.page(params[:page]).per(5)
    end
  end
      # @search_params = task_search_params 拡張性持たせるなら
    # includesでテーブルをつなげてN+1問題を解決する。
  def new
     @task = Task.new
  end
  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      redirect_to tasks_path, notice: t(".AddTask")
    else
      render :new
    end
  end
  def show
  end
  def edit
  end
  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: t(".EditTask")
    else
      render :edit
    end
  end
  def destroy
    @task.destroy
     redirect_to tasks_path, notice: t(".DestroyTask")
  end
  private
  def set_task
    @task = Task.find(params[:id])
  end
  def task_params
    params.require(:task).permit(:title,:content,:deadline,:state,:priority, { label_ids: [] })
  end
  def check_user
    # userを確認している
    if @task.user != current_user
      redirect_to tasks_path
    end
  end
end
