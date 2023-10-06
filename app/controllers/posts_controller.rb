# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[destroy show edit update]
  before_action :logged_in_user


  def index; end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    post = current_account.posts.build(set_params)
    authorize post
    if post.save
      redirect_to account_path(current_account)
    else
      redirect_to account_path(current_account), notice: 'Something went wrong'
    end
  end

  def destroy
    authorize @post

    flash.alert = if @post.destroy
                    respond_to do |format|
                      format.js
                    end
                    'Post was successfully destroyed'
                  else
                    'Something went wrong'
                  end

    # redirect_to(request.referer)
  end

  def show; end

  def edit
    authorize @post
  end

  def update
    authorize @post
    flash.alert = if @post.update(set_params)
                    'Post was successfully updated'
                  else
                    'Something went wrong'
                  end

    redirect_to account_path(current_account.id)
  end

  private

  def set_params
    @update = params.require(:post).permit(:caption)
  end

  def set_post

    if Post.exists?(id: params[:id])
      @post = Post.find_by(id: params[:id])
    else
      flash[:notice] = 'Post does not exist'
      redirect_to account_path
    end
  end
  def logged_in_user
    unless signed_in?
       flash[:danger] = "Please log in."
       redirect_to new_account_session_path
    end
 end
end
