Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :room_messages
  resources :rooms
  resources :room_users, only: [:new, :index] do
  	post :create
  end
end