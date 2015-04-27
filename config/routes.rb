Rails.application.routes.draw do
  resources :expenses, only: [:index, :new, :create]
  root to: "expenses#index"
end
