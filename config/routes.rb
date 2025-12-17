Rails.application.routes.draw do
  devise_for :users

  resources :books do
    get "order", to: "orders#new"
    post "order", to: "orders#create"
  end

  resources :books do
    resources :reviews, only: [:create]
  end

  resources :contact_messages, only: %i[new create]

  resources :orders, only: %i[new create]

  resource :cart, only: %i[show]
  post "cart/add/:book_id", to: "carts#add", as: "add_to_cart"
  post "cart/remove/:book_id", to: "carts#remove", as: "remove_from_cart"
  post "cart/checkout", to: "carts#checkout", as: "checkout_cart"

  resources :orders, only: [:index, :new, :create]

  root "books#index"
end
