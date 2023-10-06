# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :set_post
  before_action :set_like, only: [:destroy]
  before_action :already_liked?, only: %i[destroy create]
  after_action :authorize_like, only: %i[create destroy]

  def create
    @like = @post.likes.create(account_id: current_account.id)
    redirect_to(request.referer)
  end

  def destroy
    flash.alert = 'Something went wrong' unless @like.destroy
    redirect_to(request.referer)
  end

  private

  def set_post
    if Post.exists?(params[:post_id])
      @post = Post.find(params[:post_id])
    else
      flash[:notice] = Post.errors.messages
    end
  end

  def already_liked?
    Like.where(account_id: current_account.id, post_id: params[:post_id]).exists?
  end

  def set_like
    if @post.likes.exists?(id: params[:id])
      @like = @post.likes.find_by(id: params[:id])
    else
      flash[:notice] = @post.likes.errors.messages
    end
  end

  def authorize_like
    authorize @like
  end
end
