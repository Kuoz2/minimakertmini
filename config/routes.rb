Rails.application.routes.draw do
  resources :codes do 
    collection do 
      get 'last_code'
    end
  end
  resources :quick_sales do 
    collection do
      get 'ventarapida_fechas'
      get 'totalventasrapidas'
      post 'verif_befores_save_quick'
    end
  end
  resources :archives
  resources :date_expirations do
    collection do
      get 'date_product_id_on'
      get 'buscar_las_fechas_perdidas'
      get 'todaslasperdidasdos'
      post 'verif_befores_save_date'
      post 'verif_before_update_date'
    end
  end

  resources :mrmsolutions do 
    collection do 
      post 'verif_befores_save_solution'
    end
  end
  resources :config_vouchers do 
    collection do 
      post 'verif_befores_save_config'
    end
  end
  resources :archings
  resources :brands do 
    collection do 
      post 'verif_befores_save_brand'
      post 'verif_before_update_brand'
      get 'verificar_blank_marca'
    end
  end
  resources :taxes do 
    collection do 
      post 'verif_before_update_taxe'
      post 'verif_befores_save_taxe'
      get 'verificar_blank_tax'
    end
  end
  resources :decreases do
    collection do
      get 'muestra_situaciones'
      post 'verif_before_update_decrease'
    end
  end
  resources :providers do 
    collection do 
      post 'verif_befores_save_provi'
      get 'verificar_blank_provider'
    end
  end
  devise_for :users, controller: {registrations: 'users/autentications', sessions: 'users/sessions'}
  devise_scope :user do
    post '/regi', to: 'users/registrations#create'
    post '/logi', to: 'users/sessions#create'
    delete 'logout', to: 'session#destroy'
    get '/mostrar_usuarios',to: 'users/registrations#mostrar_usuarios', defaults: {format: :json}, as: 'mostrar_usuarios'
    get '/mostrar_los_usuarios', to:'users/registrations#mostrar_los_usuarios', defaults:{format: :json}, as: 'mostrar_los_usuarios'
  end

  resources :payments do
    collection do 
      post 'verif_befores_save_payme'
    end
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
        post 'verif_befores_save_d_voucher'
    end
  end

  resources :half_payments do 
    collection do
      post 'verif_befores_save_half'
    end
  end
  resources :voucher_details do

    resource :vouchers
  end
  resources :vouchers , shallow: true do
    collection do
          get 'showlast'
          get 'mostrar_ganancias_por_mes'
          post 'verif_befores_save_voucher'
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
      get 'codigos_debarra'
      post 'verif_befores_save'
      post 'verif_before_update'
      post 'envio_email_vencidos'
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
      get 'todaslasperdiadasinvprim'
      post 'verif_befores_save_stock'
      post 'verif_before_update_stock'
    end

 

  end
  resources :sales do 
    collection do 
      post 'verif_befores_save_sales'
    end
  end
  resources :categories do 
    collection do 
      post 'verif_save_category'
      post 'verif_before_update_category'
      get 'verificar_blank_category'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
