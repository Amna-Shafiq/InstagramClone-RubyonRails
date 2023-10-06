# frozen_string_literal: true

module StoriesHelper
  def correct_image_type
    if picture.attached? && !picture.content_type.in?(%w[image/jpeg image/jpg image/png image/heic])
      errors.add(:picture, 'must be an image of type JPEG, JPG, PNG or HEIC')
    elsif picture.attached? == false
      errors.add(:picture, 'required')
    end
  end
end
