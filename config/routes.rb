Rails.application.routes.draw do

  root to: 'static_pages#home'
  match 'auth/twitter/callback', to: 'sessions#create', via: [:get, :post]
  get '/dashboard', to: 'dashboard#show'

end
