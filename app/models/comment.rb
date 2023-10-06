# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :account
  belongs_to :post

  validates :content, length: {maximum: 300}, presence: true
end
