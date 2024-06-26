Rails.application.routes.draw do


devise_for :users, controllers: { registrations: 'user_management/registrations' }



  post 'cart/add_to_cart/:id', to: 'cart#add_to_cart', as: 'add_to_cart'
  get 'cart/show_cart', to: 'cart#show_cart', as: 'show_cart'
  post 'cart/remove_from_cart/:book_id', to: 'cart#remove_from_cart', as: 'remove_from_cart'

  get 'onsale', to: 'books#on_sale', as:'on_sale'
  get 'newbooks', to: 'books#new_books', as:'new_books'
  get 'recently_updated', to: 'books#recently_updated', as:'recently_updated'

  get '/remove_item_from_cart/:id', to: 'books#remove_item_from_cart', as: 'remove_item_from_cart'
  post '/increase_quantity/:id', to: 'books#increase_quantity', as: 'increase_quantity'
  post '/decrease_quantity/:id', to: 'books#decrease_quantity', as: 'decrease_quantity' 


  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  root 'books#index'

  resources :books do
    post 'add_to_cart', on: :member
  end

  resources :categories do
    resources :books, only: [:index]
  end

  get 'contact', to: 'contact#show'
  get 'about', to: 'about#show'

  get '/checkout', to: 'cart#checkout'
  patch 'update_province', to: 'cart#update_province'
  get '/invoice', to: 'cart#invoice', as: 'invoice'

  resources :cart, only: [] do
    collection do
      post 'checkout'
    end
  end

  resources :payments do
    collection do
      get 'success'
      get 'cancel'
    end
  end

  post 'payments/show', to: 'payments#show', as: 'show_payments'
  match '/pay/webhooks/stripe', to: 'stripe_webhooks#handle_event', via: [:get, :post] 
  post '/stripe/webhooks', to: 'stripe_webhooks#handle_event'

end
