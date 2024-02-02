class AttendancesController < ApplicationController
  # before_action :authenticate_admin

  def create
    error_hash = Hash(nil)

    for user_id in attendance_params[:user_id] do
      attendance = Attendance.new(user_id: user_id, activity_id: attendance_params[:activity_id])
      begin
        unless attendance.save
          error_hash[user_id] = attendance.errors.full_messages
        end
      rescue ActiveRecord::RecordNotUnique
        error_hash[user_id] = "Attendance already created!"
      end
    end

    if error_hash.length == 0
      render json: { status: "success", data: {} }, status: :created
    else
      error_render(error_hash, :bad_request)
    end
  end

  def mark
    iterate_user_ids(-> { @attendance.update_attribute(:attended, true) })
  end

  def unmark
    iterate_user_ids(-> { @attendance.update_attribute(:attended, false) })
  end

  def destroy
    iterate_user_ids(-> { @attendance.destroy })
  end

  private
  def attendance_params
    params.require(:attendance).permit(:activity_id, :user_id => [])
  end

  def iterate_user_ids(func)
    error_hash = Hash(nil)

    for user_id in attendance_params[:user_id] do
      @attendance = Attendance.find_by(user_id: user_id, activity_id: attendance_params[:activity_id])
      if @attendance
        func.call
      else
        error_hash[user_id] = "Attendance not found!"
      end
    end

    if error_hash.length == 0
      render json: { status: "success", data: {} }, status: :ok
    else
      error_render(error_hash ,:bad_request)
    end
  end
end