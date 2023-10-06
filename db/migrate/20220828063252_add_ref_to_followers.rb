# frozen_string_literal: true

class AddRefToFollowers < ActiveRecord::Migration[5.2]
  def change
    add_reference :followers, :account, foreign_key: true
  end
end
