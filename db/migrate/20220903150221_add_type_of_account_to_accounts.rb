# frozen_string_literal: true

class AddTypeOfAccountToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :type_of_account, :integer, default: 0
  end
end
