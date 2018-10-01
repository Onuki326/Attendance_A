Rails.application.routes.draw do

  get 'basictime/edit'

  get 'basictime/create'

  get 'basictime/update'

  root   'static_pages#home'
  get    '/signup',     to: 'users#new'
  post   '/signup',     to: 'users#create'
  get    '/login',      to: 'sessions#new'
  post   '/login',      to: 'sessions#create'
  delete '/logout',     to: 'sessions#destroy'
  get    '/basic_time', to: 'attendances#basic_time' 
  
  resources :users
  resources :attendances, only: [:create, :edit, :update]
  resource  :basictime,   only: [:create, :edit, :update]
end