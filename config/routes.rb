Rails.application.routes.draw do

  devise_for :users
  get "/dashboard", to: "pages#dashboard"
  get "/about", to: "pages#about"

  root to: 'neighbourhoods#index'
  resources :news, only: [:index ]
  resources :neighbourhoods, only: [:index, :show] do
    resources :services do
      resources :reviews, only: [:new, :create, :edit, :destroy]
      member do
        post "fav", to: "services#fav"
        post "unfav", to: "services#unfav"
      end
      resources :posts do
      resources :comments, except: [:destroy]
    end
      # resources :favourites, only: [:create, :destroy]
    end

  end
  resources :posts, only: [] do
    resources :comments, only: [:destroy]
  end
end
