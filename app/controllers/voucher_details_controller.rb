class VoucherDetailsController < ApplicationController
  before_action :set_voucher_detail, only: [:show, :update, :destroy]
  before_action :fecha_del_mes, only: [:show_date, :show_best_sale]
  before_action :ganancias_mensual, only: [:show_cantidad]
  before_action :ganancia_mes_pasado, only: [:show_after_month]
  before_action :producto_mas_vendido, only: [:producto_max_vend]
  # GET /voucher_details
  def index
    @voucher_details = VoucherDetail.all

    render json: @voucher_details, :include => [:voucher, :product]
  end

  def show_date
    render json: @voucher_date, :include => [:voucher, :product]
  end
 # Cantidad mensual. Muestra el total
  def show_cantidad
      #my_hash = {:ventas_mensual => @total_ventas}
    render json: @total_ventas#JSON.generate(my_hash) #[@total_ventas]
  end

  #producto mas vendido
  def producto_max_vend

    render json: @producto_max
  end

  #Ganancia del mes anterior.
  def show_after_month
    render json: @total_venta_anterior
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
    @voucher =  Voucher.new(params.permit![:voucher_id])
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

  #Mostrar ganancia del mes pasado.
  def ganancia_mes_pasado
    fecha = Time.zone.today.month
    nueva_fecha = fecha -1

    @total_venta_anterior = Voucher.all.filter{|n| n.created_at.to_s[6,1] == nueva_fecha.to_s}.map(&:vtotal).reduce(:+)
  end
    #ganancias mensuales
  def ganancias_mensual
    @total_ventas = Voucher.all.filter {|n| n.created_at.to_s[5,2] == Time.now.to_s[5,2]}.map(&:vtotal).reduce(:+)
  end

    # Only allow a trusted parameter "white list" through.
  def voucher_detail_params
    params.require(:voucher_detail).permit(:dvcantidad,
                                           :dvprecio,
                                           {:voucher_id => [:vtotal,:vnumerodebusqueda]},
                                           :product_id)
  end
end
