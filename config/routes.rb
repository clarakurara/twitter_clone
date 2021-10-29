Rails.application.routes.draw do
  root 'pages#home'
  
  get 'pages/home'
  get 'pages/about'
  get 'pages/contact'
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'

  resources :sessions, only: :create
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :users do
    member do
      get :following, :followers
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end