Rails.application.routes.draw do


  get 'suppliers/index'

  get 'suppliers/new'

  root 'suppliers#index'

  resources :suppliers



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
