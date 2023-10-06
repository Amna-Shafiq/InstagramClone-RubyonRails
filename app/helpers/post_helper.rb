# frozen_string_literal: true

module PostHelper
  def single_image(post)
    post.images.count == 1
  end
end
