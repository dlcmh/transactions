Rails.application.routes.draw do
  resources :transactions
  resources :categories
  resources :products
  resources :users

  namespace :queries do
    resources :months
    resources :monthly_sales_total
  end
end
