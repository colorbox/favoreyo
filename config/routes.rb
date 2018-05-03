Rails.application.routes.draw do
  root 'sessions#new'

  resources :sessions, only: %i(new)

  resources :user, param: :screen_name, only: %i() do
    resources :tweets, only: %i(index show)
  end
end
