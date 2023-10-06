# frozen_string_literal: true

class AddPostsToLikes < ActiveRecord::Migration[5.2]
  def change
    add_reference :likes, :post, foreign_key: true
  end
end
