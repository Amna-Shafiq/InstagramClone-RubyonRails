# frozen_string_literal: true

class AddCaptionToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :caption, :string, limit: 500
  end
end
