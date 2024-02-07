class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :full_name, :handphone, :age, :is_male, :is_admin, :created_at, :updated_at

  attributes :is_current_user_admin do |user, params|
    if params[:current_user] == nil
      false
    else
      params[:current_user][:is_admin]
    end
  end
end
