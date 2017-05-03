Rails.application.routes.draw do

  root 'stall#index'

  get 'order/all_orders'

  get 'consumer/consumer_profile'

  get 'address/customer_addresses'

  get 'company/company_profile'

  get 'pages/homepage'

  # get 'stall_profile/stall_profile'

  resources :stall

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
