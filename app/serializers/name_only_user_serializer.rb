class NameOnlyUserSerializer
  include JSONAPI::Serializer
  attributes :full_name
end
