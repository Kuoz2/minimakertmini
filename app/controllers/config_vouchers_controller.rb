class ConfigVouchersController < ApplicationController
  before_action :set_config_voucher, only: [:show, :update, :destroy]

  # GET /config_vouchers
  def index
    @config_vouchers = ConfigVoucher.all

    render json: @config_vouchers
  end

  # GET /config_vouchers/1
  def show
    render json: @config_voucher
  end

  # POST /config_vouchers
  def create
    if Rails.cache.read('PCONverificado') == 'existe'

    @config_voucher = ConfigVoucher.new(config_voucher_params)
    if @config_vouchers == []
    if @config_voucher.save
      render json: @config_voucher, status: :created, location: @config_voucher
    else
      render json: @config_voucher.errors, status: :unprocessable_entity
    end
  end
else
  render json: {resive: 'no tiene permiso'}

end
  end

  # PATCH/PUT /config_vouchers/1
  def update
    if @config_voucher.update(config_voucher_params)
      render json: @config_voucher
    else
      render json: @config_voucher.errors, status: :unprocessable_entity
    end
  end

  # DELETE /config_vouchers/1
  def destroy
    @config_voucher.destroy
  end
  def verif_befores_save_config
    puts "entra aqui"
    dato = Hash.new
    dato  = request.raw_post  
      puts "jtli entrante #{dato}"
      if User.exists?(:jti => dato)
       Rails.cache.write('PCONverificado', 'existe') 
       @informacion = {resultado: 'existe'}
    else
      Rails.cache.write('PCONverificado', 'inexistente') 
      @informacion = {resultado: 'inexistente'}
        #Ex:- :null => false
    end
    render json: @informacion
  end
#Verificar antes de actualizar
def verif_before_update_config
  puts "entra aqui"
  dato = Hash.new
  dato  = request.raw_post  
    puts "jtli entrante #{dato}"
    if User.exists?(:jti => dato)
     Rails.cache.write('Pnuverificado', 'existe') 
     @informacion = {resultado: 'existe'}
  else
    Rails.cache.write('Pnuverificado', 'inexistente') 
    @informacion = {resultado: 'inexistente'}
      #Ex:- :null => false
  end
  render json: @informacion
end

#Verificar antes de eliminar

def verif_before_delete_config
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
def verif_before_see_config
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
    def set_config_voucher
      @config_voucher = ConfigVoucher.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def config_voucher_params
      params.require(:config_voucher).permit(:RutEmpresa,
                                             :fechaEmision,
                                             :RutReceptor,
                                             :TipoDocumento,
                                             :CantidadDesde,
                                             :CantidadHasta,
                                             :FechaAutori,
                                             :numeroFolio,
                                             :montoTotal,
                                             :rasonSocial,
                                             :itemVendido,
                                             :moduloLLave,
                                             :ExponenteLLave,
                                             :identidadLLave,
                                             :fechahoraGTimbre,
                                             :firmaTimbre,
                                             :rutEmisor)
    end
end
