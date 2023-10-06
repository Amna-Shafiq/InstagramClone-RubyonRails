# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe CommentsController, type: :controller do
  let(:current_user) { create(:account) }
  let(:other_user) { create(:account) }
  let(:current_user_post) { create(:post, account_id: current_user.id) }
  let(:other_user_post) { create(:post) }
  let(:current_user_comment) { create(:comment, post_id: current_user_post.id, account_id: current_user.id) }
  let(:other_user_comment) { create(:comment, post_id: other_user_post.id, account_id: other_user.id) }

  before do
    sign_in current_user
  end

  describe 'GET #create' do
    context 'when params are valid' do
      it 'is expected to create new comment as only current user can create comments' do
        post :create, params: { post_id: current_user_post.id, comment: { content: 'content' }, format: :js }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'negative cases' do
      it 'is expected to not create new comment as post does not exist' do
        post :create, params: { post_id: -2, comment: { content: 'content' }, format: :js }
        expect(flash[:notice]).to eq('Post does not exist')
      end

      it 'is expected to not create new comment as user is signed out' do
        sign_out current_user
        post :create, params: { post_id: current_user_post.id, comment: { content: 'content' }, format: :js }
        expect(flash[:danger]).to eq('Please log in.')
      end

      it 'responds with un-successful creation of comment as content is nil' do
        allow_any_instance_of(Comment).to receive(:save!).and_return(false)
        post :create, params: { post_id: current_user_post.id, comment: { content: nil } }
        expect(flash[:notice]).to eq('Something went wrong')
      end
    end
  end

  describe 'POST #delete' do
    context 'when user deletes its own comments' do
      it 'is expected to delete comment as current user can delete its own comment' do
        delete :destroy, params: { id: current_user_comment.id, post_id: current_user_post.id }, format: :js
        expect(flash[:notice]).to eq('Comment deleted successfully')
      end
    end

    context 'negative cases' do
      it 'respond with un-successful deletion of comment if other user deletes' do
        delete :destroy,
               params: { id: other_user_comment.id, post_id: other_user_post.id, account_id: current_user.id,
                         comment: { content: 'content' } }
        expect(flash[:notice]).to eq('You are not authorized to perform this action.')
      end

      it 'is expected to not delete comment as user is signed out' do
        sign_out current_user
        delete :destroy,
               params: { id: current_user_comment.id, post_id: current_user_post.id, comment: { content: 'content' },
                         format: :js }
        expect(flash[:danger]).to eq('Please log in.')
      end

      it 'respond with un-successful deletion of comment if comment does not exist' do
        delete :destroy, params: { post_id: current_user_post.id, id: -9 }
        expect(flash[:notice]).to eq('Comment does not exist')
      end

      it 'respond with un-successful update of comment if comment is invalid' do
        allow_any_instance_of(Comment).to receive(:destroy).and_return(false)
        delete :destroy, params: { id: current_user_comment.id, post_id: other_user_post.id }
        expect(flash[:notice]).to eq('Something went wrong')
      end
    end
  end

  describe 'POST #update' do
    context 'when user updates its own comments' do
      it 'is expected to update comment as current user can edit its own comment' do
        put :update,
            params: { id: current_user_comment.id, post_id: current_user_post.id, comment: { content: 'content' } }
        expect(response).to have_http_status(:found)
      end
    end

    context 'negative cases' do
      it 'respond with un-successful update of comment if content is nil' do
        patch :update,
              params: { id: current_user_comment.id, post_id: current_user_post.id, comment: { content: nil } }
        expect(flash[:alert]).to eq('Something went wrong')
      end

      it 'respond with un-successful update of comment if other user updates' do
        patch :update,
              params: { id: other_user_comment.id, post_id: other_user_post.id, account_id: current_user.id,
                        comment: { content: 'content' } }
        expect(flash[:notice]).to eq('You are not authorized to perform this action.')
      end

      it 'is expected not to update comment as post does not exist' do
        patch :update, params: { id: 0, post_id: current_user_post.id, comment: { content: 'content' } }
        expect(flash[:notice]).to eq('Comment does not exist')
      end

      it 'respond with an alert message as user is not logged in so can not update the comment' do
        sign_out current_user
        patch :update,
              params: { id: current_user_comment.id, post_id: current_user_post.id, comment: { content: 'content' } }
        expect(flash[:danger]).to eq('Please log in.')
      end
    end
  end
end
