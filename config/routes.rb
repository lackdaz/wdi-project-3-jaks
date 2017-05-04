Rails.application.routes.draw do



  root 'supplier#index'

  resources :suppliers


  resources :consumers
  get 'pages/homepage'


  resources :stall

  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

end
