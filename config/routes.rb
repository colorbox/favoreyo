Rails.application.routes.draw do
  root 'tweets#index'

  resources :tweets, only: %i(index show)
end
