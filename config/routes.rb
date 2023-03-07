Rails.application.routes.draw do
  devise_for :users
  root to: "events#index"

  resources :gyms, only: %i[index show]

  resources :events, only: %i[index create show update destroy] do
    collection do
      get :user
    end
    member do
      get :chatroom
    end
  end
  resources :users, only: %i[show update destroy]
  resources :chatrooms, only: :index
end
