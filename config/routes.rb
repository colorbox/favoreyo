Rails.application.routes.draw do
  root 'users#index'

  resource :sessions, only: %i(new destroy)

  resources :users, param: :screen_name, only: %i(index) do
    resources :tweets, only: %i(index show)
  end
end
