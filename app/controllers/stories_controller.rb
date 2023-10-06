# frozen_string_literal: true

class StoriesController < ApplicationController
  before_action :set_account, only: [:show]
  before_action :set_story, only: %i[show_stories destroy]
  after_action :authorize_story, except: [:show]

  def new
    @story = Story.new
    @stories = Story.where(account_id: current_account)
  end

  def create
    @story = Story.new(set_params)
    @story.account_id = current_account.id
    if @story.save
      redirect_to new_story_path flash[:notice] = 'Story was successfully created'
    else
      render new_story_path flash[:notice] = 'Something went wrong'
    end
  end

  def show
    @stories = Story.where(account_id: params[:id])
    authorize @stories
  end

  def destroy
    flash.alert = if @story.destroy
                    'Story was deleted successfully'
                  else
                    'Something went wrong'
                  end
    redirect_to(request.referer)
  end

  def show_stories; end

  private

  def set_story
    if Story.exists?(id: params[:id])
      @story = Story.find_by(id: params[:id])
    else
      flash[:notice] = 'Something went wrong'
    end
  end

  def set_account
    if Account.exists?(id: params[:id])
      @account = Account.find_by(id: params[:id])
    else
      flash[:notice] = 'Something went wrong'
    end
  end

  def set_params
    params.require(:story).permit(:id, :picture)
  end

  def authorize_story
    authorize @story
  end
end
