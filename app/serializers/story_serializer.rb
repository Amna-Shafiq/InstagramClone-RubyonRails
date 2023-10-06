class StorySerializer
  include JSONAPI::Serializer
  attributes :id, :account_id, :picture, :created_at, :image_url
end
