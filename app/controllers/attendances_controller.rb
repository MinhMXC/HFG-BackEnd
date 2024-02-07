class AttendancesController < ApplicationController
  before_action :authenticate_admin, except: [:show_user]
  before_action :authenticate, only: [:show_user]
  before_action do
    find_activity(params[:id])
  end

  def show_user
    user = User.find_by(id: params[:id])
    unless user
      error_render({ full_messages: "User Not Found!" }, :bad_request)
      return
    end

    if current_user[:is_admin] == false && Integer(current_user[:id]) != Integer(params[:id])
      error_render({ full_messages: "You do not have the privilege to do this!}" }, :unauthorized)
      return
    end

    attendances = Attendance.where(user_id: params[:id])
    render json: { status: "success", data: AttendanceSerializer.new(attendances, { params: { user: true } }).serializable_hash.dig(:data) }
  end

  def show_activity
    attendances = Attendance.where(activity_id: @activity[:id])
    render json: { status: "success", data: AttendanceSerializer.new(attendances).serializable_hash.dig(:data) }
  end

  def create
    @error_hash = Hash(nil)

    attendance_params[:user_ids].each { |user_id|
      app = Application.find_by(user_id: user_id, activity_id: @activity[:id])
      if app == nil
        @error_hash[user_id] = "Application doesn't exist!"
        next
      end

      attendance = Attendance.new(user_id: user_id, activity_id: @activity[:id], applications_id: app[:id])

      begin
        unless attendance.save
          @error_hash[user_id] = attendance.errors.full_messages
        end
        app.update_attribute(:accepted, true)
      rescue ActiveRecord::RecordNotUnique
        @error_hash[user_id] = "Attendance already created!"
      end
    }

    render_response
  end

  def mark
    iterate_user_ids(-> { @attendance.update_attribute(:attended, true) })
  end

  def unmark
    iterate_user_ids(-> { @attendance.update_attribute(:attended, false) })
  end

  def destroy
    @error_hash = Hash(nil)

    attendance_params[:user_ids].each { |user_id|
      @attendance = Attendance.find_by(user_id: user_id, activity_id: @activity[:id])
      if @attendance
        @attendance.destroy
        app = Application.find_by(user_id: user_id, activity_id: @activity[:id])
        app.update_attribute(:accepted, false)
      else
        @error_hash[user_id] = "Attendance not found!"
      end
    }

    render_response
  end

  private
  def attendance_params
    params.require(:attendance).permit(:user_ids => [])
  end

  def iterate_user_ids(func)
    @error_hash = Hash(nil)

    attendance_params[:user_ids].each { |user_id|
      @attendance = Attendance.find_by(user_id: user_id, activity_id: @activity[:id])
      if @attendance
        func.call
      else
        @error_hash[user_id] = "Attendance not found!"
      end
    }

    render_response
  end

  def render_response
    if @error_hash.length == 0
      render json: { status: "success", data: {} }, status: :ok
    else
      error_render(@error_hash ,:bad_request)
    end
  end

  def find_activity(id)
    @activity = Activity.find_by(id: id)
    unless @activity
      error_render({ full_messages: "Activity Not Found!" }, :not_found)
    end
  end
end
