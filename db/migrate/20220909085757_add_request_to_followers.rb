# frozen_string_literal: true

class AddRequestToFollowers < ActiveRecord::Migration[5.2]
  def change
    add_column :followers, :request_status, :integer, default: 1
  end
end
