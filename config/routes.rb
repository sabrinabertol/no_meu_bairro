Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'
  resources :neighbourhoods, only: [:index, :show] do
    resources :services do
      resources :reviews, only: [:new, :create, :edit, :destroy]
      scope module: :services do
        resources :favorites, only: [:index, :create] do
          collection do
            delete '/', action: :destroy
          end
        end
      end
    end
    resources :news, only: [:index]
    resources :posts
  end
end
