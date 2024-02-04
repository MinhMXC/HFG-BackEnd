class ActivitySerializer
  include JSONAPI::Serializer
  attributes :id, :title, :overview, :body, :image, :manpower_needed, :location, :time_start, :time_end,
  :created_at, :updated_at

  attributes :applied do |activity, params|
    if params[:current_user] == nil
      false
    else
      Application.find_by(user_id: params[:current_user][:id], activity_id: activity.id ) != nil
    end
  end

  attributes :applications do |activity, params|
    if params[:current_user] == nil || params[:current_user][:is_admin] == false
      nil
    else
      SimpleUserSerializer
        .new(User.joins(:applications).where(:applications => {:activity_id => activity.id}))
        .serializable_hash
        .dig(:data)
    end
  end
end
