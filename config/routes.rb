Rails.application.routes.draw do
root 'suppliers#index'


  devise_for :users
  # resources :consumers

get '/profile/:id' , to: 'users#show' , as:'profile'
post '/delivery_address/new' ,to: 'delivery_address#create', as:'delivery_address_create'




  resources :stall


  # devise_for :suppliers

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
