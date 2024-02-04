class AttendanceSerializer
  include JSONAPI::Serializer
  attributes :attended, :created_at, :updated_at

  attributes :user do |attendance|
    SimpleUserSerializer.new(User.find_by(id: attendance[:user_id])).serializable_hash.dig(:data, :attributes)
  end
end
