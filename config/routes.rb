Rails.application.routes.draw do
  root to: 'home#index'

  resources :transactions
  resources :categories
  resources :products
  resources :users

  namespace :queries do
    resources :top_selling_products
    resources :worst_selling_products
    resources :months
    resources :monthly_sales_total
    resources :ranked_product_sales
    resources :bestselling_authors
  end
end
