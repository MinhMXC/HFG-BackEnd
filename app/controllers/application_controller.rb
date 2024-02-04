class ApplicationController < ActionController::API
  extend Devise::Models
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :configure_permitted_parameters, if: :devise_controller?

  def error_render(error, status)
    render json: { status: "error", errors: error }, status: status
  end

  def authenticate_admin
    unless user_signed_in?
      error_render({ full_messages: "You are not signed in!" }, :unauthorized)
      return
    end

    if current_user[:is_admin] == false
      error_render({ full_messages: "You do not have the privilege to do this!" }, :unauthorized)
      return
    end
  end

  def authenticate
    unless user_signed_in?
      error_render({ full_messages: "You are not signed in!" }, :unauthorized)
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :full_name, :handphone, :age, :is_male])
  end
end