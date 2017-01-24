Rails.application.routes.draw do
  root to: 'pages#index'

  resources :reset_passwords, only: [:new, :create, :update, :edit]

  resources :users, only: [:new, :create] do
    member do
      get :activate
    end
  end
  resources :sessions, only: [:new, :create, :destroy]

  get '/secret', to: 'pages#index', as: :secret
  get '/sign_up', to: 'users#new', as: :sign_up

  get '/log_in', to: 'sessions#new', as: :log_in
  delete '/log_out', to: 'sessions#destroy', as: :log_out
end
