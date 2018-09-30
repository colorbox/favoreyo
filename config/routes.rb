Rails.application.routes.draw do
  root 'users#index'

  resource :mypage, only: %i(show)

  resource :sessions, only: %i(new destroy)

  resources :users, param: :screen_name, only: %i(index destroy update) do
    resources :tweets, only: %i(index)
  end

  resources :tweets, only: %i(index) do
    resource :favorite, only: %i(create destroy)
  end
end
