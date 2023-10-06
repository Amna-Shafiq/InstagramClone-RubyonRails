# frozen_string_literal: true

class AddLastNameToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :last_name, :string, limit: 25
  end
end
