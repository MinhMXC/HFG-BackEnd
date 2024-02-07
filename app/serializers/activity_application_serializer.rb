class ActivityApplicationSerializer
  include JSONAPI::Serializer
  attributes :accepted, :created_at

  attributes :user do |application|
    SimpleUserSerializer.new(User.find_by(id: application[:user_id])).serializable_hash.dig(:data, :attributes)
  end
end
