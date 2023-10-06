# frozen_string_literal: true

class AddRefToLikes < ActiveRecord::Migration[5.2]
  def change
    add_reference :likes, :account, foreign_key: true, index: true
  end
end
