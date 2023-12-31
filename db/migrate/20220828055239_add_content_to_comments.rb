# frozen_string_literal: true

class AddContentToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :content, :string, limit: 300
  end
end
