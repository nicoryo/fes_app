# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'users/index'
  # get 'users/show'
  # get 'artists/show'
  devise_for :users

  resources :users, only: %i[index show new create destroy edit update] do
    resources :favs, only: %i[create destroy]
  end
  root 'users#index'
  resources :messages, only: [:create]
  resources :rooms, only: %i[create show index]
  resources :relationships, only: %i[create destroy]
  resources :favs, only: %i[create destroy]
  resources :users do
    collection { get 'search' }
  end
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :artists, only: %i[index show search new create] do
    resources :favs, only: %i[create destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
