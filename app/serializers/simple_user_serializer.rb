class SimpleUserSerializer
  include JSONAPI::Serializer
  attributes :id, :full_name, :image
end
