# frozen_string_literal: true

require_relative 'application'
Rails.application.initialize!
ActionMailer::Base.delivery_method = :smtp
