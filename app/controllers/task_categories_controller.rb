class TaskCategoriesController < ApplicationController
  before_action :authenticate_user
  before_action :set_task_category, only: [:show, :update, :destroy]

  # # GET /task_categories
  # def index
  #   @task_categories = TaskCategory.all
  #
  #   render json: @task_categories
  # end
  #
  # # GET /task_categories/1
  # def show
  #   render json: @task_category
  # end
  #
  # # POST /task_categories
  # def create
  #   @task_category = TaskCategory.new(task_category_params)
  #
  #   if @task_category.save
  #     render json: @task_category, status: :created, location: @task_category
  #   else
  #     render json: @task_category.errors, status: :unprocessable_entity
  #   end
  # end
  #
  # # PATCH/PUT /task_categories/1
  # def update
  #   if @task_category.update(task_category_params)
  #     render json: @task_category
  #   else
  #     render json: @task_category.errors, status: :unprocessable_entity
  #   end
  # end
  #
  # # DELETE /task_categories/1
  # def destroy
  #   @task_category.destroy
  # end

  def categories_all
      task_categories = TaskCategory.all
      render json: task_categories
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_category
      @task_category = TaskCategory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_category_params
      params.require(:task_category).permit(:name)
    end
end
