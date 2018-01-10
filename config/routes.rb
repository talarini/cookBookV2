Rails.application.routes.draw do
  root to: 'home#index'
  resources :recipes, only: [:show, :new, :create, :edit, :update] do
    collection do
      get 'search'
    end
  end
  
  resources :cuisines, only: [:show, :new, :create]
  resources :recipe_types, only: [:show, :new, :create]

end
