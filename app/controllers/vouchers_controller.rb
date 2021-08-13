class VouchersController < ApplicationController
  before_action :set_voucher, only: [:show, :update, :destroy]
  before_action :obtener_ganancias_con_fechas, only: [:mostrar_ganancias_por_mes]

  # GET /vouchers
  def index
    @vouchers = Voucher.all

    render json: @vouchers, :include => [:voucher_details]
  end

  # GET /vouchers/1
  def show
    render json: @voucher
  end

  #GET / SE OBTIENEN LAS GANANCIAS Y EL MES QUE SE REALIZO.
  def mostrar_ganancias_por_mes
    render json: @busqueda_fv.group_by{|h| h.keys.first}.values
                     .map{|a| {a.first.keys.first => a.inject(0){|sum, h| sum + h.values.first.to_i}.to_i
                     }}
  end

  # POST /vouchers
  def create
    @voucher = Voucher.new(voucher_params)
    if @voucher.save
      render json: @voucher, status: :created, location: @voucher
    else
      render json: @voucher.errors, status: :unprocessable_entity
    end
  end

  def showlast
    @voucher_last = Voucher.last
    if @voucher_last != 'null'
    render json: @voucher_last
    else
      render json: 0
      end
  end

  # PATCH/PUT /vouchers/1
  def update
    if @voucher.update(voucher_params)
      render json: @voucher
    else
      render json: @voucher.errors, status: :unprocessable_entity
    end
  end

  # DELETE /vouchers/1
  def destroy
    @voucher.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_voucher
      @voucher = Voucher.find(params[:id])
    end

  #MOSTRAR LAS FECHAS QUE SE REALIZARON LAS VENTAS Y ENVAR CUANTA GANANCIAS SE ISIERON.
  def obtener_ganancias_con_fechas
    informacion = []
    @fecha_y_ganancias_obtenidas = Voucher.all.filter{|fv|
      busqueda_fv(fv,informacion)
    }
    @busqueda_fv = informacion
  end

  def busqueda_fv(fv, informacion)

    case fv.created_at.to_s[5, 2].to_i
    when 1.to_s
      informacion.push({:Ene => fv.vtotal})
    when 2.to_s
      informacion.push({:Feb =>fv.vtotal})
    when 3.to_s
      informacion.push({:Marz => fv.vtotal})
    when 4.to_s
      informacion.push({:Abr => fv.vtotal})
    when 5.to_s
      informacion.push({:May => fv.vtotal})
    when 6.to_s
      informacion.push({:Jun => fv.vtotal})
    when 7.to_s
      informacion.push({:Jul => fv.vtotal})
    when 8.to_s
      informacion.push({:Agos => fv.vtotal})
    when 9.to_s
      informacion.push({:Sep => fv.vtotal})
    when 10.to_s
      informacion.push({:Oct => fv.vtotal})
    when 11.to_s
      informacion.push({:Nov => fv.vtotal})
    when 12.to_s
      informacion.push({:Dis => fv.vtotal})
    else
      informacion.push(0)
    end

  end

    # Only allow a trusted parameter "white list" through.
    def voucher_params
      params.require(:voucher).permit(:vnumerodebusqueda, :vtotal, :vdia,:vhora, :user_id,:hora_creacion)
    end
end
