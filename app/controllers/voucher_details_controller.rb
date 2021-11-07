class VoucherDetailsController < ApplicationController
  before_action :set_voucher_detail, only: [:show, :update, :destroy]
  before_action :fecha_del_mes, only: [:show_date, :show_best_sale]
  before_action :ganancias_mensual, only: [:show_cantidad]
    before_action :ganancia_mes_pasado, only: [:show_after_month]
  before_action :producto_mas_vendido, only: [:producto_max_vend]
  before_action :ganancias_totales_obtenidas,only: [:las_ganancias_totales_meses]
  # GET /voucher_details
  def index
    @voucher_details = VoucherDetail.all

    render json: @voucher_details, :include => [:voucher, :product => {:include => [:category, :brand]} ]
  end

#mOOSTRAR TODAS LAS GANANCIAS OBTENIDAS.
  def las_ganancias_totales_meses
    if @todas_las_ventas_meses == nil
      render json: 0
    else
      render json: {:ganancias_totales =>@todas_las_ventas_meses}
    end
  end

  def show_date
    render json: @voucher_date, :include => [:voucher, :product]
  end
 # Cantidad mensual. Muestra el total
  def show_cantidad
      #my_hash = {:ventas_mensual => @total_ventas}
    if @total_ventas == nil
      render json: 0
    else
      render json: {:ventas_mensual => @total_ventas}#JSON.generate(my_hash) #[@total_ventas]

    end

  end

  #producto mas vendido
  def producto_max_vend

    render json: @producto_max
  end

  #Ganancia del mes anterior.
  def show_after_month
    if @total_venta_anterior == nil
      render json: {:mes_anterior_es => 0}
    else
    render json: {:mes_anterior_es => @total_venta_anterior}
    end
  end

  # La mejor ganancias por producto.
  def show_best_sale
    @datos = VoucherDetail.all
    render json: @datos, :include => [:product]
  end

  # GET /voucher_details/1
  def show
    render json: @voucher_detail
  end
  # POST /voucher_details
  def create
    if Rails.cache.read('PDVverificado') == 'existe'
      Rails.cache.delete('PDVverificado') 
    @voucher =  Voucher.new(params.permit![:voucher])
    @voucher_detail = @voucher.voucher_details.new(voucher_detail_params)
    if @voucher_detail.save

      EnvioTicketMailer.new_envio_email(@voucher_detail).deliver
      #EnvioTicketMailer.new_envio_email(@archive).deliver
    render json: @voucher_detail, status: :created, location: @voucher_detail
    else
    render json: @voucher_detail.errors, status: :unprocessable_entity
    end
  else
    render json: {resive: 'no tiene permiso'}
    end
  end


  # PATCH/PUT /voucher_details/1
  def update
    if Rails.cache.read('Pnuverificado') == 'existe' 
      Rails.cache.delete('Pnuverificado')
      if @voucher_detail.update(voucher_detail_params)
      render json: @voucher_detail
    else
      render json: @voucher_detail.errors, status: :unprocessable_entity
    end
  else
    render json: {resive: 'no tiene permiso'}

  end
  end

  # DELETE /voucher_details/1
  def destroy
    @voucher_detail.destroy
  end
  def verif_befores_save_d_voucher
    puts "entra aqui"
    dato = Hash.new
    dato  = request.raw_post  
      puts "jtli entrante #{dato}"
      if User.exists?(:jti => dato)
       Rails.cache.write('PDVverificado', 'existe') 
       @informacion = {resultado: 'existe'}
    else
      Rails.cache.write('PDVverificado', 'inexistente') 
      @informacion = {resultado: 'inexistente'}
        #Ex:- :null => false
    end
    render json: @informacion
  end
#Verificar antes de actualizar
def verif_before_update_d_voucher
  puts "entra aqui"
  dato = Hash.new
  dato  = request.raw_post  
    puts "jtli entrante #{dato}"
    if User.exists?(:jti => dato)
     Rails.cache.write('Pnuverificado', 'existe') 
     @informacion = {resultado: 'existe'}
  else
    @informacion = {resultado: 'inexistente'}
      #Ex:- :null => false
  end
  render json: @informacion
end

#Verificar antes de eliminar

def verif_before_delete_d_voucher
  puts "entra aqui"
  dato = Hash.new
  dato  = request.raw_post  
    puts "jtli entrante #{dato}"
    if User.exists?(:jti => dato)
     Rails.cache.write('Pndverificado', 'existe') 
     @informacion = {resultado: 'existe'}
  else
    Rails.cache.write('Pndverificado', 'inexistente') 
    @informacion = {resultado: 'inexistente'}
      #Ex:- :null => false
  end
  render json: @informacion
end

#Verificar si esta verificado para ver
def verif_before_see_d_voucher
  puts "entra aqui"
  dato = Hash.new
  dato  = request.raw_post  
    puts "jtli entrante #{dato}"
    if User.exists?(:jti => dato)
     Rails.cache.write('Pnsverificado', 'existe') 
     @informacion = {resultado: 'existe'}
  else
    Rails.cache.write('Pnsverificado', 'inexistente') 
    @informacion = {resultado: 'inexistente'}
      #Ex:- :null => false
  end
  render json: @informacion
end
  private
    # Use callbacks to share common setup or constraints between actions.
  def set_voucher_detail
    @voucher_detail = VoucherDetail.find(params[:id])
  end



  #mes de actual
  def fecha_del_mes
    fecha =Time.zone.today.month
    if fecha.to_s.length == 2
    @voucher_date = VoucherDetail.all.filter do |d|
      d.created_at.to_s[5,2] == fecha.to_s
    end
    else
      @voucher_date = VoucherDetail.all.filter do |d|
        d.created_at.to_s[6,1] == fecha.to_s
      end
      end
  end

  #Productos mas vendidos
  def producto_mas_vendido

    producto_vendido =  VoucherDetail.all.map { |de|
           de.as_json(:except =>[:id,:dvprecio,:voucher_id,:product_id ,:created_at,:updated_at],
                                                                 :include => [:product => {:only =>[:pdescripcion, :pvalor, :pstock]}]) }

         @producto_max = producto_vendido
    
  end



  #Lista de fechas
  def fechas_por_nombre
    Date.new(2019,1).upto(Date.today).map{|date| "#{date::strftime('%m')}"}.uniq
  #    Date.new(2019,1).upto(Date.today).map{|date| "#{date.to_s[5..-4]}"}.uniq

    # fecha_1 = Date.new(2019,1).upto(Date.today).map{|date| "#{date.to_s[5..-4]}"}.uniq
  # fecha_1.each_with_index do |a, index|
  # contador = index +1
  # puts "#{a}:#{contador}"
  # end
  end

  #Mostrar ganancia del mes pasado.
  def ganancia_mes_pasado
    fecha = Time.zone.today.month
    nueva_fecha = fecha - 1
      if nueva_fecha.to_s.length == 2
    @total_venta_anterior = Voucher.all.filter{|n| n.created_at.to_s[5,2] == nueva_fecha.to_s}.map(&:vtotal).reduce(:+)
      else
        @total_venta_anterior = Voucher.all.filter{|n| n.created_at.to_s[6,1] == nueva_fecha.to_s}.map(&:vtotal).reduce(:+)

      end
  end

  #tODAS LAS GANANCIAS OBTENIDAS.
  def ganancias_totales_obtenidas
    @todas_las_ventas_meses = Voucher.all.map(&:vtotal).reduce(:+)
  end

    #ganancias mensuales
  def ganancias_mensual
    fecha =Time.zone.today.month
    if fecha.to_s.length == 2
    @total_ventas = Voucher.all.filter {|n| n.created_at.to_s[5,2] == fecha.to_s}.map(&:vtotal).reduce(:+)
    else
      @total_ventas = Voucher.all.filter {|n| n.created_at.to_s[6,1] == fecha.to_s}.map(&:vtotal).reduce(:+)
    end
  end
    # Only allow a trusted parameter "white list" through.
  def voucher_detail_params
    params.require(:voucher_detail).permit(:dvcantidad,
                                           :dvprecio,
                                           :fecha_emision,
                                           :hora_emision,
                                           :stadoEnv,
                                           :numerofolio,
                                           :tipoEnvio,
                                           {:voucher => [:vtotal,:vnumerodebusqueda, :vhora, :vdia]},
                                           :product_id)
  end
  #obtener fecha y dia actual.
  def obtener_fecha_dia
    mes = Time.zone.today.month
    dia = Time.zone.today.day
      
  end
end
