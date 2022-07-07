Rails.application.routes.draw do
  root to: 'items#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users, only: %i[index destroy]
  resources :categories
  resources :orders

  resources :items do
    patch :add_to_cart,      controller: :carts, action: :add_to_cart,      on: :member
    patch :remove_from_cart, controller: :carts, action: :remove_from_cart, on: :member

    resources :images, only: %i[] do
      delete :destroy, controller: :items, action: :destroy_image, on: :member
    end
  end

  get 'cart', to: 'carts#show'

  get 'admin/index',      to: 'admin#index'
  get 'admin/users',      to: 'admin#users'
  get 'admin/items',      to: 'admin#items'
  get 'admin/orders',     to: 'admin#orders'
  get 'admin/categories', to: 'admin#categories'
end
