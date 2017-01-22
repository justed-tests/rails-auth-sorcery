Rails.application.routes.draw do
  root to: 'pages#index'

  get '/secret', to: 'pages#index', as: :secret

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
