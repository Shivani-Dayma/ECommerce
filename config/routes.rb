Rails.application.routes.draw do
  # get 'categories/index'

  post '/auth/login', to: 'authentication#login'
  post 'signout', to: 'sessions#signout'
  resources :users 
  resources :categories

  resources :items do
    collection do
    get 'search'
    get 'sort'
    get 'filter'
    end
  end

  resources :carts
  resources :wishlists
  get '/*a', to: 'application#not_found'
end
