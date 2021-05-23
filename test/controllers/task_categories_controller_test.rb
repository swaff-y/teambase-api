require "test_helper"

class TaskCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task_category = task_categories(:one)
  end

  test "should get index" do
    get task_categories_url, as: :json
    assert_response :success
  end

  test "should create task_category" do
    assert_difference('TaskCategory.count') do
      post task_categories_url, params: { task_category: { name: @task_category.name } }, as: :json
    end

    assert_response 201
  end

  test "should show task_category" do
    get task_category_url(@task_category), as: :json
    assert_response :success
  end

  test "should update task_category" do
    patch task_category_url(@task_category), params: { task_category: { name: @task_category.name } }, as: :json
    assert_response 200
  end

  test "should destroy task_category" do
    assert_difference('TaskCategory.count', -1) do
      delete task_category_url(@task_category), as: :json
    end

    assert_response 204
  end
end
