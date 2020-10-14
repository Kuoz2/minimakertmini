class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]
  before_action :calcular_producto_stock, only: [:product_total_valor]
  before_action :buscando_las_perdidas,only: [:productos_perdidas]

  # GET /products
  def index
    @products = Product.all
    render json: @products, :include => [:stock, :category]
  end

  def agregando_quantity
    @producto_quantity = Product.all.as_json
    @roductos_quantity[].push({:quantity => 1})
    render :json => @producto_quantity
  end

  # GET /products/1
  def show
    render json: @product, :include=>[:stock]
  end

  #Mostrar los productos y los stock perdidos.
  def productos_perdidas
    render json: @datos_producto
  end

  #Ganancia total de los productos
  def product_total_valor
    render json: @productos_calculados
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

    #Calcular el total de los productos.
  def calcular_producto_stock
   @productos_calculados = Product.all.map { |p| p.pvalor * p.stock.pstock}
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
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
                                      :tax_id

      )

    end

end
