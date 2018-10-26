Rails.application.routes.draw do

  namespace :admin do
    resources :bases 
    resources :users do
      member do
        get :active
        get :basictime
      end
    end
  end

  root   'static_pages#home'
  get    '/signup',     to: 'users#new'
  post   '/signup',     to: 'users#create'
  get    '/login',      to: 'sessions#new'
  post   '/login',      to: 'sessions#create'
  delete '/logout',     to: 'sessions#destroy'
  
  resources :users do
    resource :attendances #only: [:create, :edit, :update]
  end
  
end