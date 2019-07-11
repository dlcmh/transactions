Rails.application.routes.draw do
  resources :transactions
  resources :categories
  resources :products
  resources :users

  namespace :queries do
    resources :months
  end
end
