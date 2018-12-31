Rails.application.routes.draw do
  root 'users#index'

  resource :mypage, only: %i(show)

  resource :sessions, only: %i(new destroy)

  resources :users, param: :screen_name, only: %i(index destroy update) do
    resources :dates, only: %i(index)
    resources :tweets, only: %i(index)
  end

  resources :lists, only: %i(index show create)
  resources :list_tweets, only: %i(index)

  resources :tweets, only: %i(index) do
    resource :favorite, only: %i(create destroy)
  end

  resources :list_tweets, only: %i(index)
end
