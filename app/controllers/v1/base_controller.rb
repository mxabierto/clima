class V1::BaseController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :authenticate_user_with_http_basic
  before_action :set_user_time_zone

  protected

  def set_user_time_zone
    Time.zone = current_user.time_zone if user_signed_in?
  end

  private

  def authenticate_user_with_http_basic
    authenticate_or_request_with_http_basic('api') do |username, password|
      user = User.find_by_email username
      user && user.valid_password?(password)
    end
  end
end
