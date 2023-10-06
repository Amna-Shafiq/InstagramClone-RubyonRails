require 'rails_helper'

RSpec.describe Story, type: :model do
  describe '#associations' do
    it { should belong_to(:account) }
  end



  describe '#story image validation' do
      context 'when image type is invalid' do
        let(:story) {  FactoryBot.build(:story, :invalid_story) }
        it 'Story not valid as image type is invalid' do
          expect(story).not_to be_valid
        end
      end

     context 'when image type is valid' do
        let(:story1) { FactoryBot.build(:story, :valid_story) }
        it 'Story is valid as image type is valid' do
          expect(story1).to be_valid
        end
      end
  end

  describe '#story callback' do
    it { callback(:call_destroy_story_job).after(:save) }
  end
end
