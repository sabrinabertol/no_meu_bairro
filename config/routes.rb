Rails.application.routes.draw do

  devise_for :users
  resources :dashboard
  root to: 'neighbourhoods#index'
  resources :news, only: [:index ]
  resources :neighbourhoods, only: [:index, :show] do
    resources :services do
      resources :reviews, only: [:new, :create, :edit, :destroy]
      resources :favourites, only: [:create, :destroy]
    end
    resources :posts do
      resources :comments, except: [:destroy]
    end
  end
  resources :posts, only: [] do
    resources :comments, only: [:destroy]
  end
end
