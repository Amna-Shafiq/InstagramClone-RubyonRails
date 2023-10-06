# frozen_string_literal: true

class AddAccountsToComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :account, foreign_key: true
  end
end
