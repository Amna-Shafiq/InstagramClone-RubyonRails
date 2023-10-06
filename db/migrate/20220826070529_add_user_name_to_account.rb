# frozen_string_literal: true

class AddUserNameToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :user_name, :string, null: false, default: '', limit: 25
    add_index :accounts, :user_name, unique: true
  end
end
