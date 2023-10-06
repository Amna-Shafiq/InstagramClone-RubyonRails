# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Account, type: :model do

  describe '#associations' do
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:stories).dependent(:destroy) }
    it { should have_many(:followers).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end

  describe '#validations' do
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:user_name) }
    it { should validate_presence_of(:email) }
    it {should validate_uniqueness_of(:user_name)}
    it {should validate_uniqueness_of(:email).ignoring_case_sensitivity}

  end

  describe '#enum' do
    it { should define_enum_for(:type_of_account).with_values(public_account: 0, private_account: 1) }
  end


  describe '#validating_images' do
    context 'when image type is invalid- validating correct_image_type helper' do
      let(:account) { FactoryBot.build(:account, :invalid_image) }
      it 'Account not valid as image type in invalid' do
       expect(account).not_to be_valid
      end
    end

    context 'when image type is valid- validating correct_image_type helper' do
      let(:account1) { FactoryBot.build(:account, :valid_image) }
      it 'Account is valid as image type in valid' do
       expect(account1).to be_valid
      end
      end
  end

  describe '#validating user_name' do
    context 'when username is present and is valid' do
      let(:account) { FactoryBot.build(:account, user_name: nil) }
      it 'Account is not valid as username is nil' do
      expect(account).not_to be_valid
      end
    end

    context 'when username is not present or is invalid' do
      let(:account) { FactoryBot.build(:account, user_name: "amna") }
       it 'Account is valid as username is present' do
       expect(account).to be_valid
      end
     end
   end

  describe '#validating email' do
    context 'when email is not present or is invalid' do
      let(:account) { FactoryBot.build(:account, email: nil) }
       it 'Account is not valid as email is nil' do
       expect(account).not_to be_valid
      end

      let(:account1) { FactoryBot.build(:account, :invalid_email) }
      it 'Account not valid as email is invalid' do
      expect(account1).not_to be_valid
      end
    end
    context 'when email is present and valid' do
      let(:account) { FactoryBot.build(:account, email: "amna@gmail.com") }
       it 'Account is valid as email is valid' do
       expect(account).to be_valid
      end

    end
  end


end
