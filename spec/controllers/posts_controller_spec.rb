# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:current_user) { create(:account) }
  let(:other_user) { create(:account) }
  let(:current_user_post) { create(:post, account_id: current_user.id) }
  let(:other_user_post) { create(:post, account_id: other_user.id) }

  before do
    sign_in current_user
  end

  describe 'GET #show' do
    context 'when correct params are given' do
      it "is expected to show current user's post" do
        get :show, params: { account_id: current_user.id, id: current_user_post.id }
        expect(assigns(:post).id).to eql current_user_post.id
      end

      it "is expected to show other user's post" do
        get :show, params: { account_id: current_user.id, id: other_user_post.id }
        expect(assigns(:post).id).to eql other_user_post.id
      end
    end

    context 'when user is logged out' do
      it 'respond with an alert message as user is not logged in so can not see its post' do
        sign_out current_user
        get :show, params: { account_id: current_user.id, id: current_user_post.id }
        expect(flash[:danger]).to eq('Please log in.')
      end

      it 'respond with an alert message as user is not logged in so can not see other users posts' do
        sign_out current_user
        get :show, params: { account_id: current_user.id, id: other_user_post.id }
        expect(flash[:danger]).to eq('Please log in.')
      end
    end
  end

  describe 'GET #new' do
    it 'is expected to create new post as only current user can create posts' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'is expected to not create new post as only logged in user can create post' do
      sign_out current_user
      get :new
      expect(flash[:danger]).to eq('Please log in.')
    end
  end

  describe 'POST #create' do
    context 'when correct params are given' do
      it 'is expected to create a new post as post is valid' do
        post :create, params: { post: { caption: 'content' } }
        expect(response).to have_http_status(:found)
      end
    end

    context 'negative cases' do
      it 'is expected to not create a new post as post is invalid' do
        allow_any_instance_of(Post).to receive(:save).and_return(false)
        post :create, params: { post: { caption: 'content' } }
        expect(flash[:notice]).to eq('Something went wrong')
      end

      it 'respond with an alert message as user is not logged in so can not create a new post' do
        sign_out current_user
        post :create, params: { post: { caption: 'content' } }
        expect(flash[:danger]).to eq('Please log in.')
      end
    end
  end

  describe 'POST #edit' do
    context 'when correct params are given' do
      it 'is expected to edit post as current user can edit the post' do
        get :edit, params: { id: current_user_post.id, account_id: current_user.id }
        expect(response).to render_template(:edit)
      end
    end

    context 'negative cases' do
      it 'is expected not to edit post as users other than current users are not authorized to edit post' do
        get :edit, params: { id: other_user_post.id }
        expect(flash[:notice]).to eq('You are not authorized to perform this action.')
      end

      it 'is expected not to edit post as post does not exist' do
        get :edit, params: { id: 0 }
        expect(flash[:notice]).to eq('Post does not exist')
      end

      it 'respond with an alert message as user is not logged in so can not edit the post' do
        sign_out current_user
        get :edit, params: { id: current_user_post.id, account_id: current_user.id }
        expect(flash[:danger]).to eq('Please log in.')
      end
    end
  end

  describe 'POST #update' do
    context 'when user updates its own post' do
      it 'is expected to update post as current user can update the post' do
        put :update, params: { id: current_user_post.id, post: { caption: 'content' } }
        expect(response).to have_http_status(:redirect)
      end
      it 'is expected to update post as user can update its own post' do
        sign_in other_user
        put :update, params: { id: other_user_post.id, post: { caption: 'content' } }
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'negative cases' do
      it 'respond with un-successful update of Post if other user updates' do
        put :update, params: { id: other_user_post.id, account_id: current_user.id, post: { caption: nil } }
        expect(flash[:notice]).to eq('You are not authorized to perform this action.')
      end

      it 'is expected not to update post as post does not exist' do
        put :update, params: { id: 0, account_id: current_user.id, post: { caption: current_user_post.caption } }
        expect(flash[:notice]).to eq('Post does not exist')
      end

      it 'respond with an alert message as user is not logged in so can not update the post' do
        sign_out current_user
        put :update,
            params: { account_id: current_user.id, id: current_user_post.id,
                      post: { caption: current_user_post.caption } }
        expect(flash[:danger]).to eq('Please log in.')
      end

      it 'respond with un-successful updation of post if post is invalid' do
        allow_any_instance_of(Post).to receive(:update).and_return(false)
        put :update,
            params: { account_id: current_user.id, id: current_user_post.id,
                      post: { caption: current_user_post.caption } }
        expect(flash[:alert]).to eq('Something went wrong')
      end
    end
  end

  describe 'POST #delete' do
    context 'when user deletes its own post' do
      it 'is expected to delete post as current user can delete post' do
        delete :destroy, params: { id: current_user_post.id, account_id: current_user.id }, format: :js
        expect(flash[:alert]).to eq('Post was successfully destroyed')
      end

      it 'is expected to delete post as user can delete its post' do
        sign_in other_user
        delete :destroy, params: { id: other_user_post.id, account_id: other_user.id }, format: :js
        expect(flash[:alert]).to eq('Post was successfully destroyed')
      end
    end

    context 'negative cases' do
      it 'is expected not to delete post as no user other the current user is authorized to delete post' do
        delete :destroy, params: { id: other_user_post.id, account_id: current_user.id }, format: :js
        expect(flash[:notice]).to eq('You are not authorized to perform this action.')
      end

      it 'is expected not to delete post as post does not exist' do
        delete :destroy, params: { id: -2, account_id: other_user.id }, format: :js
        expect(flash[:notice]).to eq('Post does not exist')
      end

      it 'respond with an alert message as user is not logged in so can not delete the post' do
        sign_out current_user
        delete :destroy, params: { id: current_user_post.id, account_id: current_user.id }, format: :js
        expect(flash[:danger]).to eq('Please log in.')
      end

      it 'respond with un-successful deletion of post if post is invalid' do
        allow_any_instance_of(Post).to receive(:destroy).and_return(false)
        delete :destroy, params: { id: current_user_post.id, account_id: current_user.id }, format: :js
        expect(flash[:alert]).to eq('Something went wrong')
      end
    end
  end
end
