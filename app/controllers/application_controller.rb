class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :basic_auth

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def configure_permitted_parameters
    keys = [:nickname, :first_name, :last_name, :first_name_kana, :last_name_kana, :birth_date]
    devise_parameter_sanitizer.permit(:sign_up, keys: keys)
    devise_parameter_sanitizer.permit(:account_update, keys: keys)
  end
end
