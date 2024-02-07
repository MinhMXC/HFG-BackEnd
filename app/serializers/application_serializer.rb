class ApplicationSerializer
  include JSONAPI::Serializer
  attributes :accepted, :created_at

  attributes :user do |application, params|
    params[:user] ? nil : SimpleUserSerializer.new(User.find_by(id: application[:user_id])).serializable_hash.dig(:data, :attributes)
  end

  attributes :activity do |application, params|
    params[:user] ? SimpleActivitySerializer.new(Activity.find_by(id: application[:activity_id])).serializable_hash.dig(:data, :attributes) : nil
  end
end
