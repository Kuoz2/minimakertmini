Rails.application.routes.draw do

  resources :providers
  devise_for :users, controller: {registrations: 'users/autentications', sessions: 'users/sessions'}
  devise_scope :user do
    post '/regi', to: 'users/registrations#create'
    post '/logi', to: 'users/sessions#create'
    get '/mostrar_usuarios',to: 'users/registrations#mostrar_usuarios', defaults: {format: :json}, as: 'mostrar_usuarios'
  end

  resources :payments do
    resource :sales
  end

  resource :stocks do

    resource :products
  end

  resources :voucher_details

  resources :half_payments
  resources :voucher_details do
    collection do
      get 'show_date'
      get 'show_cantidad'
      get 'show_best_sale'
      get 'show_cantidad'
      get 'show_after_month'
      get 'producto_max_vend'
      get 'las_ganancias_totales_meses'
    end
    resource :vouchers
  end
  resources :vouchers , shallow: true do
    collection do
          get 'showlast'
          get 'mostrar_ganancias_por_mes'
    end
  end
  resources :products, shallow: true do
    collection do
      get 'product_total_valor'
      get 'productos_perdidas'
      get 'agregando_quantity'

    end
  end
  resources :stocks do
    collection do
      get 'buscar_las_fechas_perdidas'
      get 'stock_products'
      get 'mostrat_todos'
      get 'mostrar_stock_de_perdidas'
      get 'p_mes_anterior'
    end
  end
  resources :sales
  resources :categories
  resources :brands
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
