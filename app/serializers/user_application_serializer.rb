class UserApplicationSerializer
  include JSONAPI::Serializer
  attributes :accepted, :created_at

  attributes :activity do |application|
    SimpleActivitySerializer.new(Activity.find_by(id: application[:activity_id])).serializable_hash.dig(:data, :attributes)
  end
end
