class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]
  before_action :calcular_producto_stock, only: [:product_total_valor]
  before_action :buscando_las_perdidas,only: [:productos_perdidas]
  before_action :Cantidad_producto_sinstock, only:[:inventario_gestionable]
    before_action :busqueda_productos_vencidos, only: [:tomar_productos_vencidos]
  before_action :meses_vencidos, only: [:tomar_productos_meses_vencidos]
    before_action :producto_vencido_mes, only: [:estado_vencimiento]
  before_action :vencimiento_siguiente_mes, only: [:vencimientoproximomes]
  before_action :produictos_que_vencen_ahora, only: [:obtener_fecha_productos_mes]
  # GET /products
  def index
    
    @products = Product.all
    render json: @products, :include => [:stock, :category, :brand, :date_expiration]
  end

  #Get cuanto le falta para vencer el producto
  def estado_vencimiento
    render json: @mes_vencido
  end
#Probando, la  toma de productos.
  def obtener_fecha_productos_mes
    render json: @fechas_y_productos
  end

  #Get productos que venceran el siguiente mes
  def vencimientoproximomes
    render json: @vence_el_siguiente_mes, :include => [:category, :brand, :date_expiration]
  end

  def agregando_quantity
    @producto_quantity = Product.all.as_json
    @roductos_quantity[].push({:quantity => 1})
    render :json => @producto_quantity
  end

  #GET los elementos de los productos que se deben gestionar
  def inventario_gestionable
    render json: @variables_gestionables
  end

  #GET tomar por meses los productos vencidos
  def tomar_productos_meses_vencidos
    render json: @datos_meses_vencidos
  end

  # GET /products/1
  def show
    render json: @product, :include=>[:stock, :date_expiration]
  end

  #Mostrar los productos y los stock perdidos.
  def productos_perdidas
    render json: @datos_producto
  end
#datos guardado
  #Ganancia total de los productos
  def product_total_valor
    render json: @productos_calculados
  end

  #Productos que pueden estar vencidos
  def tomar_productos_vencidos
    render json: @vencidos
  end

  # POST /products
  def guardado_especial

  end
  def create
    #@stock = Stock.new(params.permit![:stock_id])
    #@date_expiration = DateExpiration.new(params.permit![:date_expiration])
    #@product = [@stock, @date_expiration].each {|d| puts d.products.new(product_params)}
    #@stock = Stock.new(params.permit![:stock_attributes])
    #@date_expiration = DateExpiration.new(params.permit![:date_expiratoins_attributes])
 
    @product = Product.new(product_params)
    @product.create_stock!(params.permit![:stock])
    @product.create_date_expiration!(params.permit![:date_expiration])
    #@product.Stock.create(params!.permit![:stock])
    #@product.DateExpiration.create(params!.permit![:date_expiration])
    if @product.save
      #.new_envio_email.deliver_later
      ApplicationMailer.new_envio_email.deliver_now

      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end


  end


  # PATCH/PUT /products/1
  def update

    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end



  private


    #Buscar el stock y sus perdidas.
  def buscando_las_perdidas
    @datos_producto = Product.all.map {|d| {'codigo'=> d.pcodigo, 'detalle'=>d.pdetalle,'perdida'=>d.stock.stock_lost, 'idproducto'=>d.id,'idstock'=>d.stock.id} }
  end

  def Cantidad_producto_sinstock
    @variables_gestionables = []
    cantidad_gestionable = Product.all.map { |d| if d.stock.pstock <= 10 then @variables_gestionables.push(d.stock.pstock) end}
  end

    #Calcular el total de los productos.
  def calcular_producto_stock
   @productos_calculados = Product.all.map { |p| p.pvalor * p.stock.pstock}
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

  #Buscando los productos vencidos
  def busqueda_productos_vencidos
    almacen_vencido = []
    aniooactual = Time.now.strftime("%F")[0,4]
    dato_vencido = Product.all.includes(:date_expiration)
    dato_vencido.each do |r| if  r.date_expiration.fecha_vencimiento == Time.now.strftime("%F") && r.date_expiration.fecha_vencimiento[0,4] == aniooactual
                              almacen_vencido.push(Hash[id:r.date_expiration.id, fecha:r.date_expiration.fecha_vencimiento])
                              @vencidos = almacen_vencido
                               @cantidad_vencidfos = almacen_vencido.length
                             else
                               @cantidad_vencidfos = "no existe"
                               @vencidos = "No existe"
                            end
    end

  end

  #Meses en que los productos se vencieron.
  def meses_vencidos
    productos_meses_vencidos = []
    datos_por_mes = Product.all
    @datos_meses_vencidos =[]
    aniooactual = Time.now.strftime("%F")[0,4]
    @datos_meses_vencidos
    datos_por_mes.includes(:category, :date_expiration).map{ |r| if r.date_expiration.fecha_vencimiento != nil && r.date_expiration.fecha_vencimiento[0,4] === aniooactual
                           meses_en_vencido(r, productos_meses_vencidos)
                           @datos_meses_vencidos =  productos_meses_vencidos
                                               end}
  end

  #Buscar los productos que esten vencidos
  def meses_en_vencido(r, productos_vencido)
    case r.date_expiration.fecha_vencimiento[5,2]
    when "01"
      productos_vencido.push({Ene: r.pdescripcion})
    when "02"
      productos_vencido.push({Feb: r.pdescripcion})
    when "03"
      productos_vencido.push({Marz: r.pdescripcion})
    when "04"
      productos_vencido.push({Abr: r.pdescripcion})
    when "05"
      productos_vencido.push({May: r.pdescripcion})
    when "06"
      productos_vencido.push({Jun: r.pdescripcion})
    when "07"
      productos_vencido.push({Jul: r.pdescripcion})
    when "08"
      productos_vencido.push({Ago: r.pdescripcion})
    when "09"
      productos_vencido.push({Sep: r.pdescripcion})
    when "10"
      productos_vencido.push({Oct: r.pdescripcion})
    when "11"
      productos_vencido.push({Nov: r.pdescripcion})
    when "12"
      productos_vencido.push({Dec: r.pdescripcion})
    else
      []
      end
  end

  #Productos por vencer en el mes.
  def producto_vencido_mes
    productos_vencido_este_mes = []
    dias_por_vencer = []
    cantidad_vencida = []
    datos_vencido_mes = Product.all
    fecha_actual=Time.now.strftime("%F")[5,2].to_i
    caputrando = Time.now.strftime("%F")[5,2].to_i
    aniooactual = Time.now.strftime("%F")[0,4].to_i
    datos_vencido_mes.includes(:date_expiration).map do |d|
      if d.date_expiration.fecha_vencimiento != nil && d.date_expiration.fecha_vencimiento[5,2].to_i == fecha_actual && d.date_expiration.fecha_vencimiento[0,4].to_i == aniooactual
      productos_vencido_este_mes.push(d.date_expiration.fecha_vencimiento[5,2].to_i)
    #  dias_por_vencer.push(d.fecha_vencimiento.to_s[8,2] +"/"+ d.fecha_vencimiento[5,2]) ESTO ESTA POR ESTUDIAR YA QUE SE DEBE CALCULAR LOS DIAS CON LOS MESES.
        end
    end
    productos_vencido_este_mes.collect {|c| cantidad_vencida.push({vencen_en: c - caputrando})}
    @mes_vencido = cantidad_vencida
  end

  def produictos_que_vencen_ahora
    obtener_productos = Product.all
    obtener_fecha = DateExpiration.all
    tomar_producto_fecha = []
    estemes = Time.now.strftime("%F")[5,2]

    obtener_productos.includes(:date_expiration).map do |d|
          if d.date_expiration.fecha_vencimiento[5,2] === estemes then
            tomar_producto_fecha.push({descripcion: d.pdescripcion, 
              marca: d.brand.bnombre, categoria: d.category.cnombre,
               fecha_vencimiento: d.date_expiration.fecha_vencimiento})
          end
    end
    obtener_fecha.includes(:product).where.not(product_id:0).map do |x|
      if x.fecha_vencimiento[5,2] == estemes then
        tomar_producto_fecha.push(
          {fecha_vencimiento2: x.fecha_vencimiento, 
            descripcion2: x.product.pdescripcion,
              marca2: x.product.brand.bnombre,
                categoria2: x.product.category.cnombre})
      end
    end
      @fechas_y_productos = tomar_producto_fecha

  end

  #Productos que venceran el mes siguiente
  def vencimiento_siguiente_mes
    productos_a_vencer = Product.all
    fecha = Time.now.strftime("%F")[5,2].to_i + 1
    vmesiguiente = []
    productos_a_vencer.includes(:date_expiration).map do |d|
    if d.date_expiration.fecha_vencimiento != nil then 
        if d.date_expiration.fecha_vencimiento[5,2].to_i === fecha then
        vmesiguiente.push(d)
          end
      end
    end

    @vence_el_siguiente_mes = vmesiguiente
  end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:pcodigo,
                                      :pactivado,
                                      :pdescripcion,
                                      :pdetalle,
                                      :ppicture,
                                      :pvalor,
                                      :provider_id,
                                      :precio_provider,
                                      :category_id ,
                                      :pactivado,
                                      :tax_id,
                                      :brand_id,
                                      :piva,
                                      :pvneto,
                                      :pvactivacioncatalogo,
                                      {stock: %i[id pstock pstockcatalogo stock_lost stock_security]},
                                      {date_expiration: %i[id fecha_vencimiento stock_expiration]}
                                      )

    end

end
