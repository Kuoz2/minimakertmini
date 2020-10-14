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

    render json: @voucher_details, :include => [:voucher, :product]
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
    @voucher =  Voucher.new(params.permit![:voucher])
    @voucher_detail = @voucher.voucher_details.new(voucher_detail_params)
    if @voucher_detail.save
    render json: @voucher_detail, status: :created, location: @voucher_detail
    else
    render json: @voucher_detail.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /voucher_details/1
  def update
    if @voucher_detail.update(voucher_detail_params)
      render json: @voucher_detail
    else
      render json: @voucher_detail.errors, status: :unprocessable_entity
    end
  end

  # DELETE /voucher_details/1
  def destroy
    @voucher_detail.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_voucher_detail
    @voucher_detail = VoucherDetail.find(params[:id])
  end

  #mes de actual
  def fecha_del_mes
    @voucher_date = VoucherDetail.all.filter do |d|
      d.created_at.to_s[5,2] == Time.now.to_s[5,2]
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

    @total_venta_anterior = Voucher.all.filter{|n| n.created_at.to_s[6,1] == nueva_fecha.to_s}.map(&:vtotal).reduce(:+)
  end

  #tODAS LAS GANANCIAS OBTENIDAS.
  def ganancias_totales_obtenidas
    @todas_las_ventas_meses = Voucher.all.map(&:vtotal).reduce(:+)
  end

    #ganancias mensuales
  def ganancias_mensual
    fecha =Time.zone.today.month
    @total_ventas = Voucher.all.filter {|n| n.created_at.to_s[6,1] == fecha.to_s}.map(&:vtotal).reduce(:+)
  end



    # Only allow a trusted parameter "white list" through.
  def voucher_detail_params
    params.require(:voucher_detail).permit(:dvcantidad,
                                           :dvprecio,
                                           {:voucher => [:vtotal,:vnumerodebusqueda, :vhora, :vdia]},
                                           :product_id)
  end
end
