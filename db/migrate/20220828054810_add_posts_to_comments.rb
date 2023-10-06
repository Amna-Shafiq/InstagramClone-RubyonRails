# frozen_string_literal: true

class AddPostsToComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :post, foreign_key: true
  end
end
