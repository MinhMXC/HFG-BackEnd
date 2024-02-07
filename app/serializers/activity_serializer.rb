class ActivitySerializer
  include JSONAPI::Serializer
  attributes :id, :title, :overview, :body, :image, :manpower_needed, :location, :time_start, :time_end,
  :created_at, :updated_at

  attributes :application do |activity, params|
    if params[:current_user] == nil
      nil
    else
      app = Application.find_by(user_id: params[:current_user][:id], activity_id: activity.id )
      ApplicationSerializer.new(app).serializable_hash.dig(:data, :attributes)
    end
  end

  attributes :is_current_user_admin do |activity, params|
    if params[:current_user] == nil
      false
    else
      params[:current_user][:is_admin]
    end
  end
end
