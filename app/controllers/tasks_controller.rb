class TasksController < ApplicationController
  before_action :ensure_current_user

  respond_to :html, :json

  def index
    @tasks = current_user.tasks
    respond_with @tasks
  end

  def show
    @task = current_user.tasks.find(params[:id])
    respond_with @task
  end

  def new
    @task = current_user.tasks.new
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def create
    @task = current_user.tasks.new(task_params)
    @task.save
    respond_with @task, location: tasks_url
  end

  def update
    @task = current_user.tasks.find(params[:id])
    @task.update_attributes(task_params)
    respond_with @task, location: tasks_url
  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy
    respond_with @task
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title)
    end

    def ensure_current_user
      unless logged_in?
        flash[:notice] = "You must sign in first."
        redirect_to new_session_url
      end
    end
end











