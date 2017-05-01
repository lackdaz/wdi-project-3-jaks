Rails.application.routes.draw do
  get 'order/all_orders'

  get 'consumer/consumer_profile'

  get 'company/company_profile'

  get 'pages/homepage'

  get 'test/testnew'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
