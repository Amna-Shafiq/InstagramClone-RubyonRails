# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Follower, type: :model do
  describe '#associations' do
    it { should belong_to(:account) }
  end

  describe '#enum' do
    it { should define_enum_for(:request_status).with_values(pending: 0, accepted: 1) }
  end
end
