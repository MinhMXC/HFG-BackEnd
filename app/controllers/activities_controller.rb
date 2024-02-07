class ActivitiesController < ApplicationController
  before_action :authenticate_admin, only: [:create, :update, :destroy]
  before_action only: [:show, :update, :destroy] do
    find_activity(params[:id])
  end

  def index
    render json: {
      status: "success",
      data: ActivitySerializer
              .new(Activity.all, {params: { current_user: current_user }})
              .serializable_hash.dig(:data)
    }, status: :ok
  end

  def show
    success_render(@activity)
  end

  def create
    @activity = Activity.new(activity_params)

    if @activity.save
      success_render(@activity, :created)
    else
      error_render({full_messages: @activity.errors.full_messages}, :bad_request)
    end
  end

  def update
    if @activity.update(activity_params)
      success_render(@activity)
    else
      error_render({full_messages: @activity.errors.full_messages}, :bad_request)
    end
  end

  def destroy
    Attendance.where(activity_id: @activity[:id]).destroy_all
    Application.where(activity_id: @activity[:id]).destroy_all
    @activity.destroy
    render json: { status: "success", data: {} }, status: :ok
  end

  private
  def find_activity(id)
    @activity = Activity.find_by(id: id)

    unless @activity
      error_render({ full_messages: "Activity Not Found" }, :not_found)
    end
  end

  def activity_params
    params.require(:activity).permit(:title, :overview, :body, :image, :manpower_needed, :location, :time_start, :time_end)
  end

  def success_render(data, status = :ok)
    render json: {
      status: "success",
      data: ActivitySerializer
              .new(data, {params: { current_user: current_user }})
              .serializable_hash.dig(:data, :attributes)
    }, status: status
  end
end
