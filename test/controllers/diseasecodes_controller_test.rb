require 'test_helper'

class DiseasecodesControllerTest < ActionController::TestCase
  setup do
    @diseasecode = diseasecodes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:diseasecodes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create diseasecode" do
    assert_difference('Diseasecode.count') do
      post :create, diseasecode: { code: @diseasecode.code, description: @diseasecode.description, disease: @diseasecode.disease, hospitaladmin_id: @diseasecode.hospitaladmin_id }
    end

    assert_redirected_to diseasecode_path(assigns(:diseasecode))
  end

  test "should show diseasecode" do
    get :show, id: @diseasecode
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @diseasecode
    assert_response :success
  end

  test "should update diseasecode" do
    patch :update, id: @diseasecode, diseasecode: { code: @diseasecode.code, description: @diseasecode.description, disease: @diseasecode.disease, hospitaladmin_id: @diseasecode.hospitaladmin_id }
    assert_redirected_to diseasecode_path(assigns(:diseasecode))
  end

  test "should destroy diseasecode" do
    assert_difference('Diseasecode.count', -1) do
      delete :destroy, id: @diseasecode
    end

    assert_redirected_to diseasecodes_path
  end
end
