Rails.application.routes.draw do

  
  resources :foods
  resources :users, only: [:index]


  resources :recipes, only: [:index, :new, :show, :create, :edit, :update, :destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


  root to: "foods/index"
end
