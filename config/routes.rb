Rails.application.routes.draw do

  # get 'users/index'
  # get 'users/show'
  # get 'artists/show'
  devise_for :users

  resources :users, only: [:index, :show, :new, :create, :destroy, :edit, :update] do
    resources :favs, only: [:create, :destroy]
  end
  root "users#index"
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]
  resources :relationships, only: [:create, :destroy]
  resources :favs, only: [:create, :destroy]
  resources :users do
     collection {get "search"}
  end
  resources :users do
     member do
       get :following, :followers
     end
   end
  resources :artists, :only => [:index, :show, :search, :new, :create] do
    resources :favs, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
