Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :categories
  resources :products do
    collection do
      get "search"
    end
    resources :carts, only: %i[new create]
  end
  resources :schools
  resources :lists
  resources :carts, only: %i[show destroy edit update]
  resources :orders
end
