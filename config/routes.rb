Rails.application.routes.draw do
  post '/login', to: 'auth#create'

  patch '/users', to: 'users#update'
  resources :users, only: [:create]

  resources :drafts, only: [:create]

  resources :maps, only: [:index]

  resources :heroes, only: [:index]

  resources :replay_files, only: [:index, :create]
end
