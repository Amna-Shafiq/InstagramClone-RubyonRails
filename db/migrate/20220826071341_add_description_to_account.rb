# frozen_string_literal: true

class AddDescriptionToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :description, :string, limit: 200
  end
end
