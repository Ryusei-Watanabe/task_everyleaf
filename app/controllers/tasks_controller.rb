class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @task = Task.all.order(id: "DESC")
  end
  def new
     @task = Task.new
  end
  def create
    @task = Task.new(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: t(".AddTask")
      else
        render :new
      end
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
    params.require(:task).permit(:title,:content)
  end
end
