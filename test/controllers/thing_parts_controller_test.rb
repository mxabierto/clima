require 'test_helper'

class ThingPartsControllerTest < ActionController::TestCase
  setup do
    @thing_part = thing_parts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:thing_parts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create thing_part" do
    assert_difference('ThingPart.count') do
      post :create, thing_part: { field1: @thing_part.field1, field2: @thing_part.field2, field3: @thing_part.field3, name: @thing_part.name }
    end

    assert_redirected_to thing_part_path(assigns(:thing_part))
  end

  test "should show thing_part" do
    get :show, id: @thing_part
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @thing_part
    assert_response :success
  end

  test "should update thing_part" do
    patch :update, id: @thing_part, thing_part: { field1: @thing_part.field1, field2: @thing_part.field2, field3: @thing_part.field3, name: @thing_part.name }
    assert_redirected_to thing_part_path(assigns(:thing_part))
  end

  test "should destroy thing_part" do
    assert_difference('ThingPart.count', -1) do
      delete :destroy, id: @thing_part
    end

    assert_redirected_to thing_parts_path
  end
end
