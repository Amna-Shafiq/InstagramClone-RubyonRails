# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#associations' do
    it { should belong_to(:account) }
    it { should belong_to(:post) }
  end

  describe '#validations' do
    it { should validate_length_of(:content).is_at_most(300) }
    it { should validate_presence_of(:content) }
  end

  describe '#validating comment' do
    context 'when content is nil' do
      let(:content) { FactoryBot.build(:comment, content: nil) }
      it 'Comment is not valid as content is nil' do
        expect(content).not_to be_valid
      end
    end

    context 'when comment is present and valid' do
        let(:content) { FactoryBot.build(:comment, content: "content") }
        it 'Comment is valid as content is valid' do
          expect(content).to be_valid
        end
      end
  end

end
