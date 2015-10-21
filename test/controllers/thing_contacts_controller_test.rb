require 'test_helper'

class ThingContactsControllerTest < ActionController::TestCase
  setup do
    @thing_contact = thing_contacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:thing_contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create thing_contact" do
    assert_difference('ThingContact.count') do
      post :create, thing_contact: { name: @thing_contact.name, thing_id: @thing_contact.thing_id }
    end

    assert_redirected_to thing_contact_path(assigns(:thing_contact))
  end

  test "should show thing_contact" do
    get :show, id: @thing_contact
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @thing_contact
    assert_response :success
  end

  test "should update thing_contact" do
    patch :update, id: @thing_contact, thing_contact: { name: @thing_contact.name, thing_id: @thing_contact.thing_id }
    assert_redirected_to thing_contact_path(assigns(:thing_contact))
  end

  test "should destroy thing_contact" do
    assert_difference('ThingContact.count', -1) do
      delete :destroy, id: @thing_contact
    end

    assert_redirected_to thing_contacts_path
  end
end
