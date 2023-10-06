# frozen_string_literal: true

class Post < ApplicationRecord
  include PostHelper
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :images, dependent: :destroy

  validate :validate_attachment
  validates :caption, length: {
    maximum: 500
  }

  private

  def validate_attachment
    return unless images.attached?

    images.each do |image|
      unless image.content_type.in?(%w[image/jpeg image/png image/jpg])
        errors.add(:images, 'image must be of type JPEG PNG JPG')
      end
    end
  end
end
