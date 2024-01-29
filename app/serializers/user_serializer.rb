class UserSerializer
  include JSONAPI::Serializer
  attributes :full_name, :handphone, :age, :is_male, :is_admin
end
