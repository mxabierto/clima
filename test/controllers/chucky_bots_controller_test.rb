require 'test_helper'

class ChuckyBotsControllerTest < ActionController::TestCase
  setup do
    @chucky_bot = chucky_bots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:chucky_bots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create chucky_bot" do
    assert_difference('ChuckyBot.count') do
      post :create, chucky_bot: { authorization: @chucky_bot.authorization, chucky_command: @chucky_bot.chucky_command, fields: @chucky_bot.fields, i18n_plural_name: @chucky_bot.i18n_plural_name, i18n_singular_name: @chucky_bot.i18n_singular_name, migrate: @chucky_bot.migrate, public_activity: @chucky_bot.public_activity, underscore_model_name: @chucky_bot.underscore_model_name }
    end

    assert_redirected_to chucky_bot_path(assigns(:chucky_bot))
  end

  test "should show chucky_bot" do
    get :show, id: @chucky_bot
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @chucky_bot
    assert_response :success
  end

  test "should update chucky_bot" do
    patch :update, id: @chucky_bot, chucky_bot: { authorization: @chucky_bot.authorization, chucky_command: @chucky_bot.chucky_command, fields: @chucky_bot.fields, i18n_plural_name: @chucky_bot.i18n_plural_name, i18n_singular_name: @chucky_bot.i18n_singular_name, migrate: @chucky_bot.migrate, public_activity: @chucky_bot.public_activity, underscore_model_name: @chucky_bot.underscore_model_name }
    assert_redirected_to chucky_bot_path(assigns(:chucky_bot))
  end

  test "should destroy chucky_bot" do
    assert_difference('ChuckyBot.count', -1) do
      delete :destroy, id: @chucky_bot
    end

    assert_redirected_to chucky_bots_path
  end
end
