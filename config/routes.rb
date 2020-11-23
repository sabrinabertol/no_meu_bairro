Rails.application.routes.draw do

  devise_for :users
  root to: 'neighbourhoods#index'
  resources :news, only: [:index]
  resources :neighbourhoods, only: [:index, :show] do
    resources :services do
      resources :reviews, only: [:new, :create, :edit, :destroy]
      resources :favourites, only: [:create, :destroy]
    end
   
    resources :posts
  end
end
