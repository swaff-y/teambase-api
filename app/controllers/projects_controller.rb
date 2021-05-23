class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy]
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user

  # GET /projects
  def index
    @projects = Project.all

    render json: @projects
  end

  # GET /projects/1
  def show
    render json: @project
  end

  # POST /projects
  def create
    @project = Project.new(project_params)

    if @project.save
      render json: @project, status: :created, location: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
  end


  def user_projects
    projects = User.find_by(id: params[:user]).projects
    render json: projects, include: ['tasks']
  end
  
  def user_project
    project = Project.find_by(id: params[:project_id])
    render json: project,
    include: {
      tasks: {
        users: { only: [:name]}
      }
    }
  end

  def user_project_status
    project = Project.find_by(id: params[:project_id]).tasks.where(status: params[:status])
    render json: project, include: ['users']
  end

  def project_priority_update
    project = Project.find(params[:project_id])

    project.update(
      priority: params[:priority]
    )

    render json: project
  end

  def create_project
    project = Project.create(
      name: params[:name],
      due_date: params[:due_date],
      status: params[:status],
      progress: params[:progress],
      category: params[:category],
      description: params[:description]
    )

    params[:assignees].each do |assignee|
      user = User.find_by(id: assignee)
      project.users << user
    end
    ProjectCategory.find_by(id: params[:category]).projects << project

    render json: project, include: ['users','project_category']
  end

  def project_delete
    project = Project.find(params[:project_id])
    project.destroy
    render json: project
  end

  def update_project
    project = Project.find(params[:project_id])
    project.update(
      name: params[:name],
      status: params[:due_date],
      progress: params[:progress],
      description: params[:description],
      due_date: params[:due_date]
    )

    category = ProjectCategory.find_by(id: params[:category])
    if category
      category.projects << project
    end

    all_users = project.users.all
    all_users.each do |user|
      if user
        project.users.delete user
      end
    end

    params[:assignees].each do |assignee|
      user = User.find_by(id: assignee)
      if user
        project.users << user
      end
    end

    render json: project
  end

  def project_read
    project = Project.find(params[:project_id])
    render json: project, include: ['users','project_category']
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, :status, :progress, :description, :due_date, :priority, :project_category_id)
    end
end
