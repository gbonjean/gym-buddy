Rails.application.routes.draw do
  devise_for :users
  root to: "gyms#index"

  resources :gyms, only: %i[index show]

  resources :events, only: %i[index new create show] do
    member do
      get :asks
      post :show, to: "events#show_update"
      post :asks, to: "events#asks_update"
    end
  end

  resources :chatrooms, only: %i[index show] do
    resources :messages, only: :create
    member do
      get :transition, to: "chatrooms#transition"
    end
  end

  get :profile, to: "profiles#show"
  post :profile, to: "profiles#locale_update"

end
