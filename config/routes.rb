Rails.application.routes.draw do
  post '/login', to: 'auth#create'

  patch '/users', to: 'users#update'
  resources :users, only: [:create]
end
