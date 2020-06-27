Rails.application.routes.draw do
  devise_for :users

  root controller: :rooms, action: :index

  resources :room_messages
  resources :rooms 
  resources :room_users, only: [:new] do
    collection do
      post :bulk_create
    end
  end   
end