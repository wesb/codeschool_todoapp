class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks
  end

  def create
    @task = User.first.tasks.build(safe_params)
    unless @task.save
      render json: @task.errors.full_messages, status: :not_acceptable
    else
      render :show
    end
  end

  def update
    @task = Task.find(params[:id])
    unless @task.update_attributes(safe_params)
      render json: @task.errors.full_messages, status: :not_acceptable
    else
      render :show
    end
  end

  def destroy
    @task = Task.find(params[:id])
    unless @task.destroy
      render json: @task.errors.full_messages, status: :not_acceptable
    else
      render :show
    end
  end


  private

  def safe_params
    safe_attributes = [
      :user_id,
      :title,
      :completed,
    ]
    params.require(:task).permit(*safe_attributes)
  end
end
