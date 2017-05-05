Rails.application.routes.draw do

  devise_for :suppliers
  devise_for :users
  root to: "mqtt#start"

  get 'transactions/index'
  # root 'supplier#index'

  resources:supplier
  resources:orders

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
