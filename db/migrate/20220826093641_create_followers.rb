# frozen_string_literal: true

class CreateFollowers < ActiveRecord::Migration[5.2]
  def change
    create_table :followers, &:timestamps
  end
end
