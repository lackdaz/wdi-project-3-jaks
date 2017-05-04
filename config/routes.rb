Rails.application.routes.draw do

  devise_for :installs
  root 'supplier#index'

  resources :suppliers


  resources :consumers
  get 'pages/homepage'


  resources :stall

  devise_for :suppliers
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
