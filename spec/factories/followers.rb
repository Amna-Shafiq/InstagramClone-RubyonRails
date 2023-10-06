# frozen_string_literal: true

FactoryBot.define do

  factory :follower do
    account { FactoryBot.build(:account) }
    request_status { Faker::Number.between(from: 0, to: 1) }
    following {}
    account_id {account_id}
  end

end
