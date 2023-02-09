Rails.application.routes.draw do
  get 'public_recipes/index'
  devise_for :users, sign_out_via: [:get, :post]
  resources :foods 
  resources :users, only: [:index]
  resources :recipes do
    resources :recipe_foods
  end

  get '/general_shopping_list', to: 'foods#general'
  get '/public_recipes', to: 'recipes#public'

  
  root to: "foods#index"
end
