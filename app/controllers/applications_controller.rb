class ApplicationsController < ApplicationController
  before_action :authenticate, only: [:create, :destroy]
  before_action :authenticate_admin, only: [:show]
  before_action do
    find_activity(params[:id])
  end

  def show
    applications = Application.where(activity_id: @activity[:id])
    render json: { status: "success", data: ApplicationSerializer.new(applications).serializable_hash.dig(:data) }
  end

  def create
    @application = Application.new(user_id: current_user[:id], activity_id: @activity[:id])

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
    @application = Application.find_by(user_id: current_user[:id], activity_id: @activity[:id])

    unless @application
      error_render({ full_messages: "Application Not Found!" }, :not_found)
      return
    end

    if @application[:accepted] == true
      error_render({ full_messages: "Your application has already been accepted. Please contact administrators for support!" }, :not_found)
      return
    end

    @application.destroy
    render json: { status: "success", data: {} }, status: :ok
  end

  private
  def find_activity(id)
    @activity = Activity.find_by(id: id)
    unless @activity
      error_render({ full_messages: "Activity Not Found!" }, :not_found)
    end
  end
end
