class ProjectCategoriesController < ApplicationController
  before_action :set_project_category, only: [:show, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /project_categories
  def index
    @project_categories = ProjectCategory.all

    render json: @project_categories
  end

  # GET /project_categories/1
  def show
    render json: @project_category
  end

  # POST /project_categories
  def create
    @project_category = ProjectCategory.new(project_category_params)

    if @project_category.save
      render json: @project_category, status: :created, location: @project_category
    else
      render json: @project_category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /project_categories/1
  def update
    if @project_category.update(project_category_params)
      render json: @project_category
    else
      render json: @project_category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /project_categories/1
  def destroy
    @project_category.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_category
      @project_category = ProjectCategory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_category_params
      params.require(:project_category).permit(:name)
    end
end
