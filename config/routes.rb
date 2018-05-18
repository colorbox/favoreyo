Rails.application.routes.draw do
  root 'users#index'

  resource :sessions, only: %i(new destroy)

  resources :users, param: :screen_name, only: %i(index destroy) do
    resources :tweets, only: %i(index)
  end

  resources :tweets, only: %i(index) do
    resources :favorites, only: %i(create)
  end
end
