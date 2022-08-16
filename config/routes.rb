Rails.application.routes.draw do
  devise_for :users
  root to: "rooms#index"

  resources :rooms do
    get :posts, on: :collection
    get :search, on: :collection
  end

  resources :users, only: [:index, :show, :edit, :account, :profile, :update] do
    get :account, on: :collection
    get :profile, on: :collection
  end

  resources :reservations, only: [:index, :new, :create, :show]
end
