# frozen_string_literal: true

class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories, &:timestamps
  end
end
