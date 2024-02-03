class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :full_name, :handphone, :age, :is_male, :is_admin, :created_at, :updated_at
end
