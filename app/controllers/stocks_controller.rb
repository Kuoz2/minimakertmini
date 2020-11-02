class StocksController < ApplicationController
  before_action :set_stock, :only => [:update, :show, :destroy]
  before_action :stock_perdida_este_mes, only: [:mostrar_stock_de_perdidas]
  before_action :mes_anterior, only: [:p_mes_anterior]
  before_action :productos_en_stock, only: [:stock_products]
  before_action :buscar_fecha_perdidas, only: [:buscar_las_fechas_perdidas]
  # GET /stocks
  def index
    @stocks = Stock.all

    render json: @stocks
  end

  def mostrat_todos
    @list_stock = Stock.all
    render json:  @list_stock
  end

  def mostrar_stock_de_perdidas
  
    if @perdida_stock_anterior ==  []
      render json: 0
    else
          render :json =>  @perdida_stock_anterior
    end

  end

  #Prueba de busqueda del stock
  def buscar_las_fechas_perdidas
    render :json => @prueba_stock_prod.group_by {|h| h.keys.first}.values.map{|a| {a.first.keys.first => a.inject(0){|sum, h| sum + h.values.first.to_i}.to_s}}
  end

  #Mostar el stock y el valor del producto
  def stock_products
      render :json => @prod_sto
  end

  #Mostrar el total de las perdidasd del mes anterior
  def p_mes_anterior
      if @mes_anterior == nil
        render json: 0
      else
        render :json => @mes_anterior
      end
  end

  # GET /stocks/1
  def show
    render json: @stock
  end

  # POST /stocks
  def create
    @stock = Stock.new(stock_params)

    if @stock.save
      render json: @stock, status: :created, location: @stock
    else
      render json: @stock.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stocks/1
  def update
    if @stock.update(stock_params)
      render json: @stock
    else
      render json: @stock.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stocks/1
  def destroy
    @stock.destroy
  end

  private

    #Mostrar solamente las perdidas de este mes.
    def stock_perdida_este_mes
      #Fecha actual en la que estamos.
          fecha = Time.zone.today.month
      nueva_fecha = fecha

      @perdida_stock_anterior = Stock.all.filter{|sa| sa.created_at.to_s[6,1] == nueva_fecha.to_s}.as_json(include:{:products => {:only => [:pvalor]}} , :only => :stock_lost)
    end

    #Muestra las perdidas del mes anterior.
    def mes_anterior
      fecha = Time.zone.today.month - 1
      @mes_anterior = Stock.all.filter{|a| a.created_at.to_s[6,1] == fecha.to_s}.map(&:stock_lost).reduce(:+)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])

      render json: @stock
    end

    #Buscar el stock y el valor del producto
    def productos_en_stock
      fecha = Time.zone.today.month - 1
      @prod_sto = Stock.all.filter{|a| a.created_at.to_s[6,1] == fecha.to_s }.as_json( include: {:products => { :only => [:pvalor] }}, :only =>:stock_lost   )

    end
  #Buscar todas las fechas y regresar si hay perdidas
  def buscar_fecha_perdidas
      data = []
      numero ||= []
      fecha = Time.zone.today.month
      jn = []
      #Primero tengo q rutiar las fechas que estan y no estan despues debo suplementar los numeros que estan con 0
     inicio = Stock.all.
         filter{|a|
           method_name(a, data)

         }.as_json(:only => [],:include => {:products => {:only => [:id ,:pvalor]}})
      #inicio.each_entry{|d| d.each_value { |b|data.push(b)  }}
      inicio.each_entry{|d|  d.each_value{|h| numero.push(h) }  }
      @prueba_stock_prod  = data
      numero.each {|d| d.each { |c|    jn.push(c) } }
    @info = jn
  end

  def method_name(a, data)
    case a.created_at.to_s[5, 2]
    when 1.to_s
      data.push({:Ene => a.stock_lost})
    when 2.to_s
      data.push({:Feb =>a.stock_lost})
    when 3.to_s
      data.push({:Marz => a.stock_lost})
    when 4.to_s
      data.push({:Abr => a.stock_lost})
    when 5.to_s
      data.push({:May => a.stock_lost})
    when 6.to_s
      data.push({:Jun => a.stock_lost})
    when 7.to_s
      data.push({:Jul => a.stock_lost})
    when 8.to_s
      data.push({:Agos => a.stock_lost})
    when 9.to_s
      data.push({:Sep => a.stock_lost})
    when 10.to_s
      data.push({:Oct => a.stock_lost})
    when 11.to_s
      data.push({:Nov => a.stock_lost})
    when 12.to_s
      data.push({:Dis => a.stock_lost})
    else
      data.push(0)
    end
  end


  # Only allow a trusted parameter "white list" through.
    def stock_params
      params.require(:stock).permit(:pstock,:pstockcatalogo,:stock_lost,:stock_security, :provider_id)
    end
end
