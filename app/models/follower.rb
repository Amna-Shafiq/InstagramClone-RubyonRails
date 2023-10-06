# frozen_string_literal: true

class Follower < ApplicationRecord
  belongs_to :account

  enum request_status: { 'pending' => 0, 'accepted' => 1 }
end
