Rails.application.routes.draw do
  root 'rooms#index'
  devise_for :users
  resources :users
  resources :room_messages
  resources :rooms
  resources :room_users do
    post :create
  end
  resources :room_users do
    post :destroy
  end

end
