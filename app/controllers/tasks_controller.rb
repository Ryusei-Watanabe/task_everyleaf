class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    if params[:sort_expired] == "true"
      @task = Task.all.order(deadline: :desc)

    elsif params[:sort_expired] == "false"
      @task = Task.all.order(created_at: :desc)
    else
      @search_params = params[:search][:title]
      @task = Task.all.search(@search_params)
    end
      # @search_params = task_search_params 拡張性持たせるなら
    # includesでテーブルをつなげてN+1問題を解決する。
  end
  def new
     @task = Task.new
  end
  def create
    @task = Task.new(task_params)
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
    params.require(:task).permit(:title,:content,:deadline,:state)
  end
  # def task_search_params 拡張性持たせるなら
  #   params.fetch(:search, {}).permit(:title)
  # end
end
