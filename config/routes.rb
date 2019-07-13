Rails.application.routes.draw do
  root to: 'home#index'

  resources :transactions
  resources :categories
  resources :products
  resources :users

  namespace :queries do
    resources :all
    resources :bestselling_authors
    resources :monthly_sales_total
    resources :months
    resources :ranked_product_sales
    resources :top_selling_products
    resources :worst_selling_products
  end
end
