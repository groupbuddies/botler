Rails.application.routes.draw do
  devise_for :users
  resources :categories, only: [:index, :show]
  resources :expenses, only: [:index, :new, :create]
  resources :periodic_expenses, only: [:index, :new, :create]

  namespace :api, defaults: { format: :json }, contraints: { format: :json } do
    resources :categories, only: [:index, :show]
    resources :expenses, only: [:index, :show]
  end
  
  root to: "expenses#index"
end
