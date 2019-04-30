Rails.application.routes.draw do
  post '/login', to: 'auth#create'

  get '/users', to: 'users#show'
  patch '/users', to: 'users#update'
  resources :users, only: [:create]

  get '/statsets', to: 'statsets#show'

  resources :drafts, only: [:create]

  resources :maps, only: [:index]

  resources :heroes, only: [:index]

  resources :replay_files, only: [:index, :create]

  resources :matches, only: [:create]
end
