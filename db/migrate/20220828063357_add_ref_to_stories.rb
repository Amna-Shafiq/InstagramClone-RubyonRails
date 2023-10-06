# frozen_string_literal: true

class AddRefToStories < ActiveRecord::Migration[5.2]
  def change
    add_reference :stories, :account, foreign_key: true
  end
end
