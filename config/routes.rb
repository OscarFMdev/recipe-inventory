Rails.application.routes.draw do
  get 'public_recipes/index'
  devise_for :users, sign_in_via: [:get, :post]
  resources :users, only: [:index]
  
  resources :foods
 

  resources :public_recipes, only: [:index]
  resources :recipes, only: [:index, :new, :show, :create, :edit, :update, :destroy]



  root to: "foods#index"
end
