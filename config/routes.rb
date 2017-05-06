Rails.application.routes.draw do


  devise_for :users, controllers: {
    session: 'users/session'
  }

  devise_for :suppliers, controllers: {
    session: 'users/session'
  }


  root to: 'suppliers#index'

  resources :suppliers

  resources :flavours

  resources :orders
  # resources :consumers

get '/profile/:id' , to: 'users#show' , as:'profile'
post '/delivery_address/new' ,to: 'delivery_address#create', as:'delivery_address_create'


  # devise_for :suppliers

  get 'transactions/index'
  # root 'supplier#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
