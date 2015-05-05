Rails.application.routes.draw do
  devise_for :users
  resources :expenses, only: [:index, :new, :create]
  resources :periodic_expenses, only: [:index, :new, :create]
  root to: "expenses#index"
end
