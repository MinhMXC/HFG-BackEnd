class AttendanceSerializer
  include JSONAPI::Serializer
  attributes :attended, :created_at, :updated_at

  attributes :user do |attendance, params|
    params[:user] ? nil : SimpleUserSerializer.new(User.find_by(id: attendance[:user_id])).serializable_hash.dig(:data, :attributes)
  end

  attributes :activity do |attendance, params|
    params[:user] ? SimpleActivitySerializer.new(Activity.find_by(id: attendance[:activity_id])).serializable_hash.dig(:data, :attributes) : nil
  end
end
