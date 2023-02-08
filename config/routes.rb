Rails.application.routes.draw do

  resources :recipes, only: [:index, :new, :show, :create, :edit, :update, :destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
