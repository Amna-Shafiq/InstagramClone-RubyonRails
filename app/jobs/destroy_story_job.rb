# frozen_string_literal: true

class DestroyStoryJob < ApplicationJob
  queue_as :default

  def perform(story_id)
    Story.find(story_id).destroy
  end
end
