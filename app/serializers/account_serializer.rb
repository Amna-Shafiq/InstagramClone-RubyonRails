class AccountSerializer
  include JSONAPI::Serializer
  attributes :id, :profile_picture, :created_at, :image_url, :user_name
end
