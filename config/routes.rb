Rails.application.routes.draw do

  root 'stall#index'

  get 'order/all_orders'

  resources :consumers

  get 'order/all_orders'

  get 'company/company_profile'

  get 'pages/homepage'

  # get 'stall_profile/stall_profile'

  resources :stall

  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

end
