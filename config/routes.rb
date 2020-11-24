Rails.application.routes.draw do

  devise_for :users
  root to: 'neighbourhoods#index'
  resources :neighbourhoods, only: [:index, :show] do
    resources :services do
      resources :reviews, only: [:new, :create, :edit, :destroy]
      member do
        post "fav", to: "services#fav"
        post "unfav", to: "services#unfav"
      end

      # resources :favourites, only: [:create, :destroy]
    end
    resources :news, only: [:index]
    resources :posts
  end
end
