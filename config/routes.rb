Rails.application.routes.draw do
  
  resources :foods
  resources :users, only: [:index]

  root to: "foods/index"
end
