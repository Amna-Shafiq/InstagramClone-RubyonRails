# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_post, only: %i[ edit update create]
  before_action :set_comment, only: %i[destroy edit update ]
  after_action :authorize_comment, only: %i[create ]
  before_action :logged_in_user

  def new;end
  def edit; end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.account_id = current_account.id
    if @comment.save!
      @count = @post.comments.count
      respond_to do |format|
        format.js
      end
    else
      flash[:notice] = 'Something went wrong'
      redirect_to accounts_path
    end
  end

  def destroy
    authorize @comment
    if @comment.destroy
      flash[:notice]= 'Comment deleted successfully'
      redirect_to post_path(set_post)

    else
      redirect_to accounts_path, notice: 'Something went wrong'
    end
  end

  def update
    authorize @comment
    flash.alert = if @comment.update(comment_params)
                    'Comment was successfully updated'
                  else
                    'Something went wrong'
                  end

    redirect_to post_path(set_post)

    # redirect_to params[:previous_request]
  end

  private

  def set_post
    if Post.exists?(id: params[:post_id])
      @post = Post.find_by(id: params[:post_id])
    else
      redirect_to accounts_path, notice: 'Post does not exist'
    end
  end

  def set_comment

    if Comment.exists?(id: params[:id])
      @comment = Comment.find_by(id: params[:id])
    else
      flash[:notice] = 'Comment does not exist'
      redirect_to post_path(set_post)


    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def authorize_comment
    authorize @comment
  end



  def logged_in_user
    unless signed_in?
       flash[:danger] = "Please log in."
       redirect_to new_account_session_path
    end
 end

end
