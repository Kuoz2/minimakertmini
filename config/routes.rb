Rails.application.routes.draw do
  resources :quick_sales
  resources :archives
  resources :date_expirations do
    collection do
      get 'date_product_id_on'
    end
  end

  resources :mrmsolutions
  resources :config_vouchers
  resources :archings
  resources :brands
  resources :taxes
  resources :decreases do
    collection do
      get 'muestra_situaciones'
    end
  end
  resources :providers
  devise_for :users, controller: {registrations: 'users/autentications', sessions: 'users/sessions'}
  devise_scope :user do
    post '/regi', to: 'users/registrations#create'
    post '/logi', to: 'users/sessions#create'
    delete 'logout', to: 'session#destroy'
    get '/mostrar_usuarios',to: 'users/registrations#mostrar_usuarios', defaults: {format: :json}, as: 'mostrar_usuarios'
    get '/mostrar_los_usuarios', to:'users/registrations#mostrar_los_usuarios', defaults:{format: :json}, as: 'mostrar_los_usuarios'
  end

  resources :payments do
    resource :sales
  end
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
  end

  resources :half_payments
  resources :voucher_details do

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
      get 'inventario_gestionable'
      get 'tomar_productos_vencidos'
      get 'tomar_productos_meses_vencidos'
      get 'estado_vencimiento'
      get 'vencimientoproximomes'
      get 'obtener_fecha_productos_mes'
    end
  end

  resources :stocks, shallow: true do
    collection do
      get 'buscar_las_fechas_perdidas'
      get 'stock_products'
      get 'mostrat_todos'
      get 'mostrar_stock_de_perdidas'
      get 'p_mes_anterior'
      get 'stock_product_id_on'
    end

  end
  resources :sales
  resources :categories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
