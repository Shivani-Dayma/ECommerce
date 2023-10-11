Rails.application.routes.draw do

  post '/auth/login', to: 'authentication#login'


    resources :users 
     resources :items
     resources :carts
    resources :wishlists

    get '/*a', to: 'application#not_found'

end
