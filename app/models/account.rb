# frozen_string_literal: true

class Account < ApplicationRecord
  include ApplicationHelper
  include AccountsHelper

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :stories, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :followers, dependent: :destroy
  has_one_attached :profile_picture, dependent: :destroy

  validates :user_name, uniqueness: true, presence: true
  validate :correct_image_type
  validates :email, format: { with: Devise.email_regexp }, presence: true
  validates :password, presence: true

  enum type_of_account: { 'public_account' => 0, 'private_account' => 1 }
  def image_url
    Rails.application.routes.url_helpers.url_for(profile_picture) if profile_picture.attached?
  end

end
