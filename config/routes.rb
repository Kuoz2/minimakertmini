Rails.application.routes.draw do

  devise_for :users, controller: {registrations: 'users/autentications', sessions: 'users/sessions'}
  devise_scope :user do
    post '/regi', to: 'users/registrations#create'
    post '/logi', to: 'users/sessions#create'
  end

  resources :payments do
    resource :sales
  end

  resource :stocks do
    resource :products
  end

  resources :half_payments
  resources :voucher_details do
    collection do
      get 'show_date'
      get 'show_cantidad'
      get 'show_best_sale'
      get 'show_cantidad'
      get 'show_after_month'
      get 'producto_max_vend'
    end
    resource :vouchers
  end
  resources :vouchers , shallow: true do
    collection do
          get 'showlast'
      end
  end
  resources :products do
    collection do
      get 'product_total_valor'
    end
  end
  resources :stocks
  resources :sales
  resources :categories
  resources :brands
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
