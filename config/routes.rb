Rails.application.routes.draw do

  get 'transactions/index'

    # devise_for :users,
    # controllers: {
    #   :sessions => 'users/sessions',
    #   :registrations =>'users/registrations'
    # },
    # path: '/',
    # path_names: {
    #   sign_in: 'login',
    #   sign_out: 'logout',
    #   sign_up: 'signup',
    #   edit: 'editprofile',
    # }

  devise_for :deliverymen
  devise_for :users, controllers: {
    session: 'users/session'
  }

  devise_for :suppliers, controllers: {
    session: 'users/session',
    registrations: 'suppliers/registrations'
  }

  root to: 'suppliers#index'
  get 'suppliers/location_search'
  resources :suppliers

  resources :flavours
  resources :containers

  resources :orderitems
  resources :invoices

get '/profile/:id' , to: 'users#show' , as:'profile'
post '/delivery_address/new' ,to: 'delivery_address#create', as:'delivery_address_create'


get '/delivery_address/edit/:id' , to:'delivery_address#edit_delivery_address', as:'delivery_address_edit'

put '/delivery_address/update/:id' , to:'delivery_address#update_delivery_address', as:'delivery_address_update'

delete '/delivery_address/delete/:id' , to:'delivery_address#destroy_delivery_address', as:'delivery_address_delete'

post '/image/new', to:'pictures#addimage',as:'add_image'


  get 'transactions/index'
  # root 'supplier#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
