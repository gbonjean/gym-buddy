Rails.application.routes.draw do
  devise_for :users
  root to: "gyms#index"



  resources :gyms, only: %i[index show]

  resources :events, only: %i[index create show update destroy] do
    member do
      get :chatroom
      get :asks
      post :show, to: "events#show_update"
      post :asks, to: "events#asks_update"
    end
  end
  resources :users, only: %i[show update destroy]
  resources :chatrooms, only: :index
end
