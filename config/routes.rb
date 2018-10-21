Rails.application.routes.draw do

  namespace :admin do
    resources :users do
      member do
        get :active
      end  
    end
  end

  root   'static_pages#home'
  get    '/signup',     to: 'users#new'
  post   '/signup',     to: 'users#create'
  get    '/login',      to: 'sessions#new'
  post   '/login',      to: 'sessions#create'
  delete '/logout',     to: 'sessions#destroy'
  
  resources :users
  resources :attendances, only: [:create, :edit, :update]
  resource  :basictime,   only: [:create, :edit, :update]
end