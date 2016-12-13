Rails.application.routes.draw do

  get 'hello_world', to: 'hello_world#index'
  root to: 'static_pages#home'
  match 'auth/twitter/callback', to: 'sessions#create', via: [:get, :post]
  get '/dashboard', to: 'dashboard#show'

  mount ActionCable.server => '/cable'

end
