# frozen_string_literal: true

class AddRefToPosts < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :account, foreign_key: true
  end
end
