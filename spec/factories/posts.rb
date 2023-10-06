FactoryBot.define do
  factory :post do
      caption { Faker::Lorem.paragraph_by_chars(number: 500) }
      account_id {}
      after(:build) do |post|
        post.images.attach(io: File.open(Rails.root.join('spec', 'factories', 'images', 'image1.png')),
                              filename: 'image1.png', content_type: 'image/png')
      end
  end
  trait :invalid_post do
    after(:build) do |post|
      post.images.attach(io: File.open(Rails.root.join('spec', 'factories', 'images', 'demo_1.webp')),
                                     filename: 'demo_1.webp', content_type: 'image/webp')
    end
  end

  trait :valid_post do
    after(:build) do |post|
      post.images.attach(io: File.open(Rails.root.join('spec', 'factories', 'images', 'image1.png')),
      filename: 'image1.png', content_type: 'image/png')
    end
  end
end
