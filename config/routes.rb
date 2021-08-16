Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'
  post 'posts/new' => 'posts#new'
  resources :posts do
    resources :comments, only: :create
  end
  resources :users, only: :show
end
