Rails.application.routes.draw do
  
  root   'static_pages#home'
  get    '/signup',     to: 'users#new'
  post   '/signup',     to: 'users#create'
  get    '/login',      to: 'sessions#new'
  post   '/login',      to: 'sessions#create'
  delete '/logout',     to: 'sessions#destroy'
  
  resources :users do
    resource :normal, only: [:update]
    resource :overtime
    resource :attendances do
      resource :revise do
        member do
          get :modal
        end
      end
    end
  end
  
  namespace :admin do
    resources :bases 
    resources :users do
      member do
        get :active
        get :basictime
      end
    end
  end
  
end