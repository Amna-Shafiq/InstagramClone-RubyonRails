FactoryBot.define do
  factory :story do
    account { FactoryBot.build(:account) }
      account_id {account.id}
      after(:build) do |story|
        story.picture.attach(io: File.open(Rails.root.join('spec', 'factories', 'images', 'image1.png')),
                              filename: 'image1.png', content_type: 'image/png')
      end
  end
  trait :invalid_story do
    after(:build) do |story|
      story.picture.attach(io: File.open(Rails.root.join('spec', 'factories', 'images', 'demo_1.webp')),
                                     filename: 'demo_1.webp', content_type: 'image/webp')
    end
  end

  trait :valid_story do
    after(:build) do |story|
      story.picture.attach(io: File.open(Rails.root.join('spec', 'factories', 'images', 'image1.png')),
      filename: 'image1.png', content_type: 'image/png')
    end
  end
end
