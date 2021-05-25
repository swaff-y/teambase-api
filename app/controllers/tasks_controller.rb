class TasksController < ApplicationController
  before_action :authenticate_user
  before_action :set_task, only: [:show, :update, :destroy]

  #
  # # GET /tasks
  # def index
  #   @tasks = Task.all
  #
  #   render json: @tasks
  # end
  #
  # # GET /tasks/1
  # def show
  #   render json: @task
  # end
  #
  # # POST /tasks
  # def create
  #   @task = Task.new(task_params)
  #
  #   if @task.save
  #     render json: @task, status: :created, location: @task
  #   else
  #     render json: @task.errors, status: :unprocessable_entity
  #   end
  # end
  #
  # # PATCH/PUT /tasks/1
  # def update
  #   if @task.update(task_params)
  #     render json: @task
  #   else
  #     render json: @task.errors, status: :unprocessable_entity
  #   end
  # end
  #
  # # DELETE /tasks/1
  # def destroy
  #   @task.destroy
  # end

  def create_task
    task = Task.create(
      name: params[:name],
      due_date: params[:due_date],
      status: params[:status],
      progress: params[:progress],
      description: params[:description],
      project_id: params[:project_id]
    )

    params[:assignees].each do |assignee|
      user = User.find_by(id: assignee)
      task.users << user
    end
    TaskCategory.find_by(id: params[:category]).tasks << task

    render json: task, include: ['users','task_category']
  end

  def delete_task
    task = Task.find(params[:task_id])
    task.destroy
    render json: task
  end

  def read_task
    task = Task.find(params[:task_id])
    render json: task, include: ['users','task_category']
  end

  def update_task
    task = Task.find(params[:task_id])

    task.update(
      name: params[:name],
      due_date: params[:due_date],
      status: params[:status],
      progress: params[:progress],
      category: params[:category],
      description: params[:description],
      project_id: params[:project_id]
    )

    category = TaskCategory.find_by(id: params[:category])
    if category
      category.tasks << task
    end

    all_users = task.users.all
    all_users.each do |user|
      if user
        task.users.delete user
      end
    end

    params[:assignees].each do |assignee|
      user = User.find_by(id: assignee)
      if user
        task.users << user
      end
    end

    render json: {
      success: true
    }
  end

  def task_priority_update
    task = Task.find(params[:task_id])

    task.update(
      priority: params[:priority]
    )

    render json: {
      success: true
    }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :start_date, :status, :description, :project_id, :progress, :task_category_id, :due_date, :priority)
    end
end
