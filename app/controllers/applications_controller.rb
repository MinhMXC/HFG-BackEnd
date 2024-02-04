class ApplicationsController < ApplicationController
  # before_action :authenticate
  #
  # TODO before action find activity

  def show
    activity = Activity.find_by(id: params[:id])
    if activity == nil
      error_render({ full_messages: "Activity Not Found!" }, :not_found)
    else
      applications = Application.where(activity_id: params[:id])
      render json: { status: "success", data: ApplicationSerializer.new(applications).serializable_hash.dig(:data) }
    end
  end

  def create
    @application = Application.new(user_id: current_user[:id], activity_id: params[:id])

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
    @application = Application.find_by(user_id: current_user[:id], activity_id: params[:id])

    unless @application
      error_render({ full_messages: "Application Not Found!" }, :not_found)
      return
    end

    @application.destroy
    render json: { status: "success", data: {} }, status: :ok
  end
end
