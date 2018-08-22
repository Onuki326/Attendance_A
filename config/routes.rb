Rails.application.routes.draw do

  root 'static_pages#home'
  get 'static_pages/home'
  get '/users/edit',  to:  'users#edit'
  
  # resources :users
end
