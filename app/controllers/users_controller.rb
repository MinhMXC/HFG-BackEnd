class UsersController < ApplicationController
  before_action :authenticate, only: [:show, :show_simple, :update]
  before_action :authenticate_admin, only: [:index, :mark_as_administrator]
  before_action only: [:show, :update] do
    find_user(params[:id])
  end

  def index
    success_render(User.all)
  end

  def show
    if current_user[:is_admin]
      success_render(@user)
    elsif current_user[:id] == @user[:id]
      success_render(@user)
    else
      error_render({ full_messages: "Unauthorized to view other users!" }, :unauthorized)
    end
  end

  def show_simple
    render json: { status: "success", data: SimpleUserSerializer.new(current_user).serializable_hash.dig(:data, :attributes) }, status: :ok
  end

  def update
    if @user.update(user_update_params)
      success_render(@user)
    else
      error_render(@user.errors, :bad_request)
    end
  end

  def mark_as_administrator
    @user.update_attribute(:is_admin, true)
    success_render(@user)
  end

  private
  def find_user(id)
    @user = User.find_by(id: id)

    unless @user
      error_render({ full_messages: "User Not Found!" }, :not_found)
    end
  end

  def success_render(data, status = :ok)
    render json: { status: "success", data: UserSerializer.new(data).serializable_hash.dig(:data, :attributes) }, status: status
  end

  def user_update_params
    params.require(:user).permit(:full_name, :handphone, :age)
  end
end
