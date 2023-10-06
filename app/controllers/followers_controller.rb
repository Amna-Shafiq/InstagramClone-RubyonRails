# frozen_string_literal: true

class FollowersController < ApplicationController
  before_action :set_follower, only: [:destroy]
  before_action :already_followed?, only: [:create]

  def create
    @follower = Follower.new(account_id: current_account.id, following: params[:account_id])
    authorize @follower
    @follower.pending! if private_account?
    flash[:notice] = 'Something went wrong' unless @follower.save!
    redirect_to(request.referer)
  end

  def destroy
    authorize @follower
    @follower.destroy unless not_followed?
    redirect_to(request.referer)
  end

  private

  def set_follower
    if Follower.exists?(account_id: params[:account_id], following: params[:id])
      @follower = Follower.find_by(account_id: params[:account_id], following: params[:id])
    else
      flash[:notice] = 'Something went wrong'
    end
  end

  def not_followed?
    true if Follower.exists?(account_id: current_account.id) == false
  end

  def already_followed?
    if Follower.exists?(account_id: current_account.id, following: params[:id])
      flash[:notice] = "You can't follow more than once"
      false
    end
  end

  def set_params
    params.require[:followers].permit(:account_id, :following)
  end

  def private_account?
    Account.find(params[:account_id]).private_account?
  end
end
