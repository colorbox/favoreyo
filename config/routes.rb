Rails.application.routes.draw do
  root 'tweets#index'

  resources :sessions, only: %i(new)

  resources :tweets, only: %i(index show)
end
