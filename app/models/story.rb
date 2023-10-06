# frozen_string_literal: true

class Story < ApplicationRecord
  include StoriesHelper

  after_save :call_destroy_story_job

  belongs_to :account
  has_one_attached :picture

  validate :correct_image_type

  def call_destroy_story_job
    DestroyStoryJob.set(wait: 24.hours).perform_later(id)
  end

  def image_url
    Rails.application.routes.url_helpers.url_for(picture) if picture.attached?
  end
end
