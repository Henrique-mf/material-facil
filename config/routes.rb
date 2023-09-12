Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'home/index'

  devise_for :users
  root to: "pages#home"
  get 'profile', to: 'pages#profile'
  # namespace :admin do
  #   root to: "/admin"
  # end

  resources :carts, only: %i[show] do
    member do
      delete 'clear_cart', to: 'carts#clear_cart'
      get 'checkout' # Add a custom checkout route
    end
  end

  resources :categories
  resources :products do
    collection do
      get 'search'
    end
    member do
      post 'buy_product'
    end
    resources :cart_items, only: %i[new create]
  end

  resources :cart_items, only: %i[destroy] do
    member do
      patch 'add_quantity'
      patch 'remove_quantity'
    end
  end

  resources :schools, only: [:index, :show]
  resources :lists, only: [:show]
  resources :orders do
    collection do
      get 'new_index'
    end
  end

  patch 'carts/add_list_to_cart/:list_id', to: 'carts#add_list_to_cart', as: :add_list_to_cart
  patch 'carts/:id/add_item', to: 'carts#add_item', as: :cart_add_item
  patch 'carts/:id/remove_item', to: 'carts#remove_item', as: :cart_remove_item
end
