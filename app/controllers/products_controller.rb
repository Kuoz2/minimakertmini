class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]
  before_action :calcular_producto_stock, only: [:product_total_valor]
  before_action :buscando_las_perdidas,only: [:productos_perdidas]
  before_action :Cantidad_producto_sinstock, only:[:inventario_gestionable]
  before_action :busqueda_productos_vencidos, only: [:tomar_productos_vencidos]
  before_action :meses_vencidos, only: [:tomar_productos_meses_vencidos]
  before_action :producto_vencido_mes, only: [:estado_vencimiento]
  before_action :vencimiento_siguiente_mes, only: [:vencimientoproximomes]

  # GET /products
  def index
    @products = Product.all
    render json: @products, :include => [:stock, :category, :brand]
  end

  #Get cuanto le falta para vencer el producto
  def estado_vencimiento
    render json: @mes_vencido
  end
  #Get productos que venceran el siguiente mes
  def vencimientoproximomes
    render json: @vence_el_siguiente_mes, :include => [:category, :brand]
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
    render json: @product, :include=>[:stock]
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
  def create
    @stock = Stock.new(params.permit![:stock_id])

    @product = @stock.products.new(product_params)
    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product, status: :unprocessable_entity
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
    dato_vencido = Product.all.select(:id,:fecha_vencimiento)
    dato_vencido.each do |r| if  r.fecha_vencimiento == Time.now.strftime("%F") && r.fecha_vencimiento[0,4] == aniooactual
                              almacen_vencido.push(Hash[id:r.id, fecha:r.fecha_vencimiento])
                              @vencidos = almacen_vencido
                               @cantidad_vencidfos = almacen_vencido.length
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
    datos_por_mes.includes(:category).map{ |r| if r.fecha_vencimiento != nil && r.fecha_vencimiento[0,4] === aniooactual
                           meses_en_vencido(r, productos_meses_vencidos)
                           @datos_meses_vencidos =  productos_meses_vencidos
                                               end}
  end

  #Buscar los productos que esten vencidos
  def meses_en_vencido(r, productos_vencido)
    case r.fecha_vencimiento[5,2]
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
      productos_vencido.push(Hash.new({Jul: r.pdescripcion}))
    when "08"
      productos_vencido.push(Hash.new({Ago: r.pdescripcion}))
    when "09"
      productos_vencido.push(Hash.new({Sep: r.pdescripcion}))
    when "10"
      productos_vencido.push(Hash.new({Oct: r.pdescripcion}))
    when "11"
      productos_vencido.push(Hash.new({Nov: r.pdescripcion}))
    when "12"
      productos_vencido.push(Hash.new({Dec: r.pdescripcion}))
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
    aniooactual = Time.now.strftime("%F")[0,4]
    datos_vencido_mes.map do |d|
      if d.fecha_vencimiento != nil && d.fecha_vencimiento == fecha_actual && d.fecha_vencimiento[0,4] == aniooactual
      productos_vencido_este_mes.push(d.fecha_vencimiento.to_s[5,2].to_i)
    #  dias_por_vencer.push(d.fecha_vencimiento.to_s[8,2] +"/"+ d.fecha_vencimiento[5,2]) ESTO ESTA POR ESTUDIAR YA QUE SE DEBE CALCULAR LOS DIAS CON LOS MESES.
        end
    end
    productos_vencido_este_mes.collect {|c| cantidad_vencida.push({vencen_en: c - caputrando})}
    @mes_vencido = cantidad_vencida

  end

  #Productos que venceran el mes siguiente
  def vencimiento_siguiente_mes
    productos_a_vencer = Product.all.select(:id,:fecha_vencimiento,:pdescripcion,:category_id,:brand_id)
    fecha = Time.now.strftime("%F")[5,2].to_i + 1
    vmesiguiente = []
    productos_a_vencer.map do |d|
      if d.fecha_vencimiento != nil
        if d.fecha_vencimiento.to_s[5,2].to_i + 1 == fecha
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
                                      :pvalor,
                                      :category_id ,
                                      {:stock_id => [:pstock,:pstockcatalogo,:stock_lost,:stock_security]},
                                      :pvactivacioncatalogo,
                                      :ppicture,
                                      :provider_id,
                                      :precio_provider,
                                      :tax_id,
                                      :piva,
                                      :brand_id,
                                      :pvneto,
                                      :fecha_vencimiento

      )

    end

end
