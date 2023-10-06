# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  devise_for :accounts

  namespace :api do
    namespace :v1 do
      resources :stories, only: [:index, :show]
      resources :accounts, only: [:index, :show]

    end
  end

  resources :accounts do
    resources :followers, only: %i[create destroy]
  end
  resources :stories, except: %i[edit index update]
  resources :requests, only: %i[index update]

  resources :posts do
    resources :likes, only: %i[create destroy]
    resources :comments, except: %i[index show]
  end

  devise_scope :account do
    authenticated :account do
      root 'accounts#index', as: :authenticated_root
    end

    unauthenticated :account do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  get 'stories/show_stories/:id', to: 'stories#show_stories', as: :show_stories
  get 'search', to: 'search#index'
end
