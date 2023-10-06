# frozen_string_literal: true

FactoryBot.define do

  factory :account do
    user_name { Faker::Name.name[0..14] }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }

  end

  trait :invalid_image do
    after(:build) do |account|
      account.profile_picture.attach(io: File.open(Rails.root.join('spec', 'factories', 'images', 'demo_1.webp')),
                                     filename: 'demo_1.webp', content_type: 'image/webp')
    end
  end

  trait :valid_image do
    after(:build) do |account|
      account.profile_picture.attach(io: File.open(Rails.root.join('spec', 'factories', 'images', 'image1.png')),
                            filename: 'image1.png', content_type: 'image/png')
    end
  end

  trait :invalid_email do
    after(:build) do |account|
      account.email = %w[user@foo,com user_at_foo.org example.user@foo.
                         foo@bar_baz.com foo@bar+baz.com]
    end
  end
end
