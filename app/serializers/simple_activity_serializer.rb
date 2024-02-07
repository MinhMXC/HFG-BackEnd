class SimpleActivitySerializer
  include JSONAPI::Serializer
  attributes :id, :title, :overview
end
