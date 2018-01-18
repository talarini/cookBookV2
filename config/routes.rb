Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :recipes, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    collection do
      get 'search'
      get 'favorites'
    end
    member do
      post 'favorite'
      delete 'destroy_favorite'
      post 'share'
    end
  end

  resources :cuisines, only: [:show, :new, :create]
  resources :recipe_types, only: [:show, :new, :create]
end
