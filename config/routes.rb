Rails.application.routes.draw do
  root to: 'home#index'
  resources :recipes, only: [:show, :new, :create, :edit, :update]
  resources :cuisines, only: [:show, :new, :create]
  resources :recipe_types, only: [:show, :new, :create]

get "/search" => "recipes#search", as: :search_recipe
  #get "/search" => "recipes#search", as :search_recipe

end
