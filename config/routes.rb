Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'
  post 'posts/new' => 'posts#new'
  resources :posts
  resources :users, only: :show
end
