class StocksController < ApplicationController
  before_action :set_stock, :only => [:update, :show, :destroy]
  before_action :stock_perdida_este_mes, only: [:mostrar_stock_de_perdidas]
  before_action :mes_anterior, only: [:p_mes_anterior]
  before_action :productos_en_stock, only: [:stock_products]
  before_action :buscar_fecha_perdidas, only: [:buscar_las_fechas_perdidas]
  before_action :totalperdidasinventario1, only:[:todaslasperdiadasinvprim]
  # GET /stocks
  def index
    @stocks = Stock.all.where(product_id: 0)

    render json: @stocks, :include => [:product]
  end

  def stock_product_id_on
    @stocks = Stock.all.where.not(product_id: 0 )
    render json: @stocks, :include => [:product]
  end

  #Mostrar todas las perdidas
  def todaslasperdiadasinvprim
    render json:{totalperdiasinv: @totalperdiadsinv1}
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
    if Rails.cache.read('PSverificado') == 'existe'
      Rails.cache.delete('PSverificado')
    @stock = Stock.new(stock_params)

    if @stock.save
      render json: @stock, status: :created, location: @stock
    else
      render json: @stock.errors, status: :unprocessable_entity
    end
   else
    render json: {resive: 'no tiene permiso'}
   end
  end



  # PATCH/PUT /stocks/1
  def update
    if Rails.cache.read('PSnuverificado') == 'existe' 
      Rails.cache.delete('PSnuverificado')
    if @stock.update(stock_params)
      render json: @stock
    else
      render json: @stock.errors, status: :unprocessable_entity
    end
  else
    render json: {resive: 'no tiene permiso'}

  end
  end

  # DELETE /stocks/1
  def destroy
    @stock.destroy
  end
  def verif_befores_save_stock
    puts "entra aqui"
    dato = Hash.new
    dato  = request.raw_post  
      puts "jtli entrante #{dato}"
      if User.exists?(:jti => dato)
       Rails.cache.write('PSverificado', 'existe') 
       @informacion = {resultado: 'existe'}
    else
      @informacion = {resultado: 'inexistente'}
        #Ex:- :null => false
    end
    render json: @informacion
  end
#Verificar antes de actualizar
def verif_before_update_stock
  puts "entra aqui"
  dato = Hash.new
  dato  = request.raw_post  
    puts "jtli entrante #{dato}"
    if User.exists?(:jti => dato)
     Rails.cache.write('PSnuverificado', 'existe') 
     @informacion = {resultado: 'existe'}
  else
    @informacion = {resultado: 'inexistente'}
      #Ex:- :null => false
  end
  render json: @informacion
end

#Verificar antes de eliminar

def verif_before_delete_stock
  puts "entra aqui"
  dato = Hash.new
  dato  = request.raw_post  
    puts "jtli entrante #{dato}"
    if User.exists?(:jti => dato)
     Rails.cache.write('Pndverificado', 'existe') 
     @informacion = {resultado: 'existe'}
  else
    @informacion = {resultado: 'inexistente'}
      #Ex:- :null => false
  end
  render json: @informacion
end

#Verificar si esta verificado para ver
def verif_before_see_stock
  puts "entra aqui"
  dato = Hash.new
  dato  = request.raw_post  
    puts "jtli entrante #{dato}"
    if User.exists?(:jti => dato)
     Rails.cache.write('Pnsverificado', 'existe') 
     @informacion = {resultado: 'existe'}
  else
    @informacion = {resultado: 'inexistente'}
      #Ex:- :null => false
  end
  render json: @informacion
end
  private

    #Mostrar solamente las perdidas de este mes.
    def stock_perdida_este_mes
      #Fecha actual en la que estamos.
          fecha = Time.zone.today.month
      nueva_fecha = fecha

          if nueva_fecha.to_s.length == 2
      @perdida_stock_anterior = Stock.all.filter{|sa| sa.created_at.to_s[5,2] == nueva_fecha.to_s}.as_json(include:{:products => {:only => [:pvalor]}} , :only => :stock_lost)
          else
            @perdida_stock_anterior = Stock.all.filter{|sa| sa.created_at.to_s[6,1] == nueva_fecha.to_s}.as_json(include:{:products => {:only => [:pvalor]}} , :only => :stock_lost)
          end

    end

    #Muestra las perdidas del mes anterior.
    def mes_anterior
      fecha = Time.zone.today.month - 1
      if fecha.to_s.length == 2
        @mes_anterior = Stock.all.filter{|a| a.created_at.to_s[5,2] == fecha.to_s}.map(&:stock_lost).reduce(:+)

      else
        @mes_anterior = Stock.all.filter{|a| a.created_at.to_s[6,1] == fecha.to_s}.map(&:stock_lost).reduce(:+)
      end
      end

    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    #Total de perdidas ocurridas-
    def totalperdidasinventario1
      
        @totalperdiadsinv1 = Stock.all.map(&:stock_lost).reduce(:+) 
      
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
    case a.created_at.to_s[5, 2].to_i
    when 1
      data.push({:Ene => a.stock_lost})
    when 2
      data.push({:Feb =>a.stock_lost})
    when 3
      data.push({:Marz => a.stock_lost})
    when 4
      data.push({:Abr => a.stock_lost})
    when 5
      data.push({:May => a.stock_lost})
    when 6
      data.push({:Jun => a.stock_lost})
    when 7
      data.push({:Jul => a.stock_lost})
    when 8
      data.push({:Agos => a.stock_lost})
    when 9
      data.push({:Sep => a.stock_lost})
    when 10
      data.push({:Oct => a.stock_lost})
    when 11
      data.push({:Nov => a.stock_lost})
    when 12
      data.push({:Dis => a.stock_lost})
    else
      []
    end

   
  end


  # Only allow a trusted parameter "white list" through.
    def stock_params
      params.require(:stock).permit(:pstock,:pstockcatalogo,:stock_lost,:stock_security, :provider_id, :product_id)
    end
end
