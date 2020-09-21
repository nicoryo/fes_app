Rails.application.routes.draw do

  get 'users/index'
  get 'users/show'
  get 'artists/show'
  devise_for :users

  resources :artists, :only => [:index, :show, :search, :new, :create] do
    resources :favs, only: [:create, :destroy]
  end


  resources :users, :only => [:index, :show, :music]
  root "users#index"
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]
  resources :relationships, only: [:create, :destroy]
  resources :users do
     collection {get "search"}
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
