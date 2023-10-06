require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#associations' do
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe '#validations' do
    it { should validate_length_of(:caption).is_at_most(500) }
  end

  describe '#validating image type' do
    context 'image type is incorrect' do
      let(:post) { FactoryBot.build(:post, :invalid_post) }
      it 'Post not valid as image type is invalid' do
        expect(post).not_to be_valid
      end
    end

    context 'image type is correct' do
      let(:post1) { FactoryBot.build(:post, :valid_post) }
      it 'Post valid as image type is valid' do
        expect(post1).to be_valid
      end
    end
  end

  describe '#validating caption' do
    context 'caption is incorrect' do
      let(:post1) { FactoryBot.build(:post, caption: Faker::Alphanumeric.alpha(number: 501)) }
      it 'Post is not valid as caption is off the limit-500' do
        expect(post1).not_to be_valid
      end
    end

    context 'caption is correct' do
      let(:post) { FactoryBot.build(:post, caption: Faker::Alphanumeric.alpha(number: 500)) }
      it 'Post is valid as caption is with in the limit-500' do
        expect(post).to be_valid
      end
    end
  end
end
