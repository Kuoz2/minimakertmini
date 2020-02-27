Rails.application.routes.draw do

  devise_for :users, skip: %i[registrations sessions passwords]
  devise_scope :user do
    post '/signup', to: 'registrations#create'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
  end
  resources :payments do
    resource :sales
  end


  resources :half_payments
  resources :voucher_details
  resources :vouchers , shallow: true do
  resource :voucher_details
  end
  resources :products
  resources :sales
  get 'category/index'
  get 'product/index'
  get 'voucher/index'
  resources :categories
  resources :brands
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
