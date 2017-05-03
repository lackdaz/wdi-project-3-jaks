Rails.application.routes.draw do

  resources :consumers

  get 'order/all_orders'

  get 'company/company_profile'

  get 'pages/homepage'

  get 'test/testnew'

  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

end
