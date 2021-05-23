require "test_helper"

class ProjectCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project_category = project_categories(:one)
  end

  test "should get index" do
    get project_categories_url, as: :json
    assert_response :success
  end

  test "should create project_category" do
    assert_difference('ProjectCategory.count') do
      post project_categories_url, params: { project_category: { name: @project_category.name } }, as: :json
    end

    assert_response 201
  end

  test "should show project_category" do
    get project_category_url(@project_category), as: :json
    assert_response :success
  end

  test "should update project_category" do
    patch project_category_url(@project_category), params: { project_category: { name: @project_category.name } }, as: :json
    assert_response 200
  end

  test "should destroy project_category" do
    assert_difference('ProjectCategory.count', -1) do
      delete project_category_url(@project_category), as: :json
    end

    assert_response 204
  end
end
