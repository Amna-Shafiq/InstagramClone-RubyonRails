require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '#associations' do
    it { should belong_to(:account) }
    it { should belong_to(:post) }
  end

  describe '#validation' do
    it 'expect to pass when account_id is unique wrt post_id'do
      create(:like)
      should validate_uniqueness_of(:account_id).scoped_to(:post_id)
    end
  end

end


