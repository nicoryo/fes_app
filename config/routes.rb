# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  mount ActionCable.server => '/cable'
  get '/show_additionally', to: 'rooms#show_additionally'
  get '/show_follower', to: 'users#show_follower'

  root 'users#index'
  resources :users, only: %i[index show create destroy edit update] do
    resources :favs, only: %i[create destroy]
    collection do
      get 'search'
    end
    member do
      get 'following', 'followers'
    end
  end
  resources :messages, only: [:create]
  resources :rooms, only: %i[create show index]
  resources :relationships, only: %i[create destroy]
  resources :favs, only: %i[create destroy]
  resources :artists, only: %i[index show search new create] do
    resources :favs, only: %i[create destroy]
    resources :comments, only: %i[create destroy]
  end
  resources :comments, only: %i[index show create destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
