# frozen_string_literal: true

require 'faker'
require 'open-uri'

Account.destroy_all
def image_fetcher
  URI.parse(Faker::Avatar.image).open
end

arr = %w[public_account private_account]
user_name = 'Admin'
email = 'admin@instagram.com'
password = 'admins'
type_of_account = arr[rand(0..1)]
u = Account.new(user_name: user_name, email: email, password: password, type_of_account: type_of_account)
u.profile_picture.attach(io: image_fetcher, filename: 'test.jpeg', content_type: 'image/*')
u.save!
3.times do
  username = Faker::Name.name
  email = Faker::Internet.unique.safe_email
  password = Faker::Internet.password
  type_of_account = arr[rand(0..1)]
  u = Account.new(user_name: username, email: email, password: password, type_of_account: type_of_account)
  u.profile_picture.attach(io: image_fetcher, filename: 'test.png', content_type: 'image/*')
  u.save!
end
caption = Faker::Lorem.paragraph_by_chars(number: 20)
accounts_all = Account.all
accounts_all.each do |account|
  p = account.posts.new(caption: caption)
  p.images.attach(io: image_fetcher, filename: 'test.png', content_type: 'image/*')
  p.save!
end
