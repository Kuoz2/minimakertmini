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
    if Rails.cache.read('PVverificado') == 'existe'
      Rails.cache.delete('PVverificado')
      @voucher = Voucher.new(voucher_params)
    if @voucher.save
      render json: {guardado:'correctamente'}, status: :created, location: @voucher
    else
      render json: @voucher.errors, status: :unprocessable_entity
    end
  else
    render json: {resive: 'no tiene permiso'}
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
    if Rails.cache.write('Pnuverificado') == 'existe' 
      Rails.cache.delete('Pnuverificado')
      if @voucher.update(voucher_params)
      render json: @voucher
    else
      render json: @voucher.errors, status: :unprocessable_entity
    end
  else
    render json: {resive: 'no tiene permiso'}

  end
  end

  # DELETE /vouchers/1
  def destroy
    @voucher.destroy
  end
  def verif_befores_save_voucher
    puts "entra aqui"
    dato = Hash.new
    dato  = request.raw_post  
      puts "jtli entrante #{dato}"
      if User.exists?(:jti => dato)
       Rails.cache.write('PVverificado', 'existe') 
       @informacion = {resultado: 'existe'}
    else
      @informacion = {resultado: 'inexistente'}
        #Ex:- :null => false
    end
    render json: @informacion
  end
#Verificar antes de actualizar
def verif_before_update_voucher
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

def verif_before_delete_voucher
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
def verif_before_see_voucher
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
    def set_voucher
      @voucher = Voucher.find(params[:id])
    end

  #MOSTRAR LAS FECHAS QUE SE REALIZARON LAS VENTAS Y ENVAR CUANTA GANANCIAS SE ISIERON.
  def obtener_ganancias_con_fechas
    informacion = []
    @fecha_y_ganancias_obtenidas = Voucher.all.map{|fv|
      busqueda_fv(fv,informacion)
    }
    @busqueda_fv = informacion
  end

  def busqueda_fv(fv, informacion)

    case fv.created_at.to_s[6, 2].to_i
    when 1
      informacion.push({:Ene => fv.vtotal})
    when 2
      informacion.push({:Feb =>fv.vtotal})
    when 3
      informacion.push({:Marz => fv.vtotal})
    when 4
      informacion.push({:Abr => fv.vtotal})
    when 5
      informacion.push({:May => fv.vtotal})
    when 6
      informacion.push({:Jun => fv.vtotal})
    when 7
      informacion.push({:Jul => fv.vtotal})
    when 8
      informacion.push({:Agos => fv.vtotal})
    when 9
      informacion.push({:Sep => fv.vtotal})
    when 10
      informacion.push({:Oct => fv.vtotal})
    when 11
      informacion.push({:Nov => fv.vtotal})
    when 12
      informacion.push({:Dis => fv.vtotal})
    else
      informacion.push({:sinfecha => 0})
    end

  end

    # Only allow a trusted parameter "white list" through.
    def voucher_params
      params.require(:voucher).permit(:vnumerodebusqueda, :vtotal, :vdia,:vhora, :user_id,:hora_creacion)
    end
end
