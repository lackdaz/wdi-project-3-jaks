Rails.application.routes.draw do


  devise_for :deliverymen
  devise_for :users, controllers: {
    session: 'users/session'
  }

  devise_for :suppliers, controllers: {
    session: 'users/session'
  }




  root to: 'suppliers#index'

  resources :suppliers

  resources :flavours
  resources :containers
  resources :orders
  # resources :consumers

get '/profile/:id' , to: 'users#show' , as:'profile'
post '/delivery_address/new' ,to: 'delivery_address#create', as:'delivery_address_create'

get '/delivery_address/edit/:id' , to:'delivery_address#edit_delivery_address', as:'delivery_address_edit'

put '/delivery_address/update/:id' , to:'delivery_address#update_delivery_address', as:'delivery_address_update'

delete '/delivery_address/delete/:id' , to:'delivery_address#destroy_delivery_address', as:'delivery_address_delete'



  # devise_for :suppliers

  get 'transactions/index'
  # root 'supplier#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
