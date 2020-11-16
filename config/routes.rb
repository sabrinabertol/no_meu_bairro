Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'
  resources :neighbourhoods, only: [:index, :show] do
    resources :services do
      resources :reviews, only: [:new, :create, :edit, :destroy]
      resources :favourites, only: [:create, :destroy]
    end
    resources :news, only: [:index]
    resources :posts

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
