
module Api
  module V1
    class StoriesController < ApplicationController

      def index
        @stories = Story.all

        render json: StorySerializer.new(@stories).serializable_hash{[:data][:attributes]}
      end

      def show
        @story = Story.find(params[:id])
        render json: StorySerializer.new(@story).serializable_hash[:data][:attributes]

      end
    end

  end
end
