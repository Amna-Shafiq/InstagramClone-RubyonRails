# frozen_string_literal: true

module AccountsHelper
  def correct_image_type
    if profile_picture.attached? && !profile_picture.content_type.in?(%w[image/jpeg image/jpg image/png image/heic])
      errors.add(:profile_picture, 'must be an image of type JPEG, JPG, PNG or HEIC')
    end
  end

  def followers_count(account)
    Follower.where(following: account.id, request_status: 'accepted').count
  end

  def find_follower(account)
    Follower.find { |follow|  follow.account_id == current_account.id && follow.following == account.id }
  end

  def find_like(post)
    post.likes.find { |like| like.account_id == current_account.id }
  end

  def show_like(post)
    post.likes.count == 1 ? 'Like' : 'Likes'
  end

  def follower_exists(user)
    Follower.exists?(account_id: current_account.id, following: user.id, request_status: 'accepted')
  end
end
