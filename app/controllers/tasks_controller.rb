class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    if params[:sort_expired] == "true"
      @task = Task.deadline_sort
    # elsif params[:sort_expired] == "false" あとで使うかな？
    else
      @task = Task.created_at_sort
      # @task = Task.all.order(created_at: :desc)
    end
    # params[:search].blank?はモデルに書いてあるよ
    if params[:task].present?
      if params[:task][:title].present? && params[:task][:state].present?
        @task = Task.title_search(params[:task][:title]).state_search(params[:task][:state]).created_at_sort
      elsif params[:task][:title].present?
        @task = Task.title_search(params[:task][:title]).created_at_sort
      elsif params[:task][:state].present?
        @task = Task.state_search(params[:task][:state]).created_at_sort
      end
    end

  end
      # @search_params = task_search_params 拡張性持たせるなら
    # includesでテーブルをつなげてN+1問題を解決する。
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
  # def task_search_params
  #   params.fetch(:task, {}).permit(:title, :state)
  # end
end
