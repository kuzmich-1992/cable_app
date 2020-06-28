Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :room_messages
  resources :rooms do
    collection do
    	post :create
    end
  end   
  resources :room_users     #, only: [:new, :index] do
end