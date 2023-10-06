# frozen_string_literal: true

class AddFirstNameToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :first_name, :string, limit: 25
  end
end
