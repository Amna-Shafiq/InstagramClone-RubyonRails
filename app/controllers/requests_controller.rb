# frozen_string_literal: true

class RequestsController < ApplicationController
  before_action :set_follower, only: :update

  def index
    @followers = Follower.where(following: current_account.id, request_status: 'pending')
  end

  def update
    if @follower.accepted! && @follower.save!
      redirect_to request.referer flash[:notice] = 'Follow request accepted'
    else
      render request.referer flash[:notice] = @follower.errors.messages
    end
  end

  private

  def set_follower
    if Follower.exists?(id: params[:id])
      @follower = Follower.find_by(id: params[:id])
    else
      flash[:notice] = @follower.errors.messages
    end
  end
end
