class ApplicationsController < ApplicationController
  before_action :authenticate

  def create
    @application = Application.new(application_params)
    @application[:user_id] = current_user[:id]

    begin
    if @application.save
      render json: { status: "success", data: {} }, status: :created
    else
      error_render(@application.errors.full_messages, :bad_request)
    end
    rescue ActiveRecord::RecordNotUnique
      error_render({ full_messages: "You have already applied!" }, :bad_request)
    end
  end

  def destroy
    @application = Application.find_by(application_params)

    unless @application
      error_render({ full_messages: "Application Not Found!" }, :not_found)
      return
    end

    @application.destroy
    render json: { status: "success", data: {} }, status: :ok
  end

  private
  def application_params
    params.require(:application).permit(:activity_id)
  end
end
