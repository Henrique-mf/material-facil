Rails.application.routes.draw do
  get 'home/index'
  get 'checkouts/show'
  
  devise_for :users
  root to: "pages#home"
  get 'profile', to: 'pages#profile'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :categories
  resources :products do
    collection do
      get 'search'
    end
    resources :carts, only: %i[new create]
  end
  resources :schools
  resources :lists
  resources :carts, only: %i[show destroy edit update index]
  resources :orders
  resources :grades
  patch 'carts/:id/add_item', to: 'carts#add_item', as: :cart_add_item
  patch 'carts/:id/remove_item', to: 'carts#remove_item', as: :cart_remove_item
end
