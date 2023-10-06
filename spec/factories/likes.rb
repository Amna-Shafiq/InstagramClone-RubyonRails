FactoryBot.define do
  factory :like do
    account { FactoryBot.build(:account) }
    post { FactoryBot.build(:post, account_id: account.id)}
    post_id { post.id }
    account_id { account.id }
  end
end
