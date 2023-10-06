# frozen_string_literal: true

FactoryBot.define do

  factory :comment do
    account { FactoryBot.build(:account) }
    post { FactoryBot.build(:post, account_id: account.id)}
    content { Faker::Lorem.paragraph_by_chars(number: 20) }
    post_id { post.id }
    account_id { account.id }
  end

end
