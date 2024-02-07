class ApplicationsController < ApplicationController
  before_action :authenticate, only: [:create, :destroy, :show_user]
  before_action :authenticate_admin, only: [:show_activity]
  before_action only: [:show, :create, :destroy, :show_activity] do
    find_activity(params[:id])
  end

  def index
    applications = Application.all
    render json: { status: "success", data: ApplicationSerializer.new(applications, { params: { user: true } }).serializable_hash.dig(:data) }
  end

  def show_user
    user = User.find_by(id: params[:id])
    unless user
      error_render({ full_messages: "User Not Found!" }, :bad_request)
      return
    end

    if current_user[:is_admin] == false && Integer(current_user[:id]) != Integer(params[:id])
      error_render({ full_messages: "You do not have the privilege to do this!" }, :unauthorized)
      return
    end

    applications = Application.where(user_id: params[:id])
    render json: { status: "success", data: ApplicationSerializer.new(applications, { params: { user: true } }).serializable_hash.dig(:data) }
  end

  def show

  end

  def show_activity
    applications = Application.where(activity_id: @activity[:id])
    render json: { status: "success", data: ApplicationSerializer.new(applications, { params: { user: false } }).serializable_hash.dig(:data) }
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
