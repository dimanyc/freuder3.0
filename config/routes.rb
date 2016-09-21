Rails.application.routes.draw do
  root to: 'static_pages#home'
  get '/users/:id', :to => 'users#show', :as => :user
end
