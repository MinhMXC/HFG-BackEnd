module Overrides
  class SessionsController < DeviseTokenAuth::SessionsController
    protected def render_create_error_bad_credentials
      if resource_params[:username].present?
        identifier = "username"
      else
        identifier = "email"
      end

      if User.where(identifier => resource_params[identifier]).blank?
        render json: { status: "error", errors: { full_messages: "Invalid password and #{identifier}!" } }, status: :unauthorized
      else
        render json: { status: "error", errors: { full_messages: "Invalid password!" } }, status: :unauthorized
      end
    end
  end
end