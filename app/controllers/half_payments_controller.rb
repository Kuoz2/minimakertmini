class HalfPaymentsController < ApplicationController
  before_action :set_half_payment, only: [:show, :update, :destroy]

  # GET /half_payments
  def index
    @half_payments = HalfPayment.all

    render json: @half_payments
  end

  # GET /half_payments/1
  def show
    render json: @half_payment
  end

  # POST /half_payments
  def create
    if Rails.cache.read('PHverificado') == 'existe'
      Rails.cache.delete('PHverificado')
    @half_payment = HalfPayment.new(half_payment_params)

    if @half_payment.save
      render json: {guardado:'correctamente'}, status: :created, location: @half_payment
    else
      render json: @half_payment.errors, status: :unprocessable_entity
    end
  else
    render json: {resive: 'no tiene permiso'}
  end
  end

  # PATCH/PUT /half_payments/1
  def update
    if Rails.cache.read('PHnuverificado') == 'existe' 
      Rails.cache.delete('PHnuverificado')
      if @half_payment.update(half_payment_params)
      render json: @half_payment
    else
      render json: @half_payment.errors, status: :unprocessable_entity
    end
  else
    render json: {resive: 'no tiene permiso'}

  end
  end

  # DELETE /half_payments/1
  def destroy
    @half_payment.destroy
  end
  
  def verif_befores_save_half
    puts "entra aqui"
    dato = Hash.new
    dato  = request.raw_post  
      puts "jtli entrante #{dato}"
      if User.exists?(:jti => dato)
       Rails.cache.write('PHverificado', 'existe') 
       @informacion = {resultado: 'existe'}
    else
      @informacion = {resultado: 'inexistente'}
        #Ex:- :null => false
    end
    render json: @informacion
  end
#Verificar antes de actualizar
def verif_before_update_half
  puts "entra aqui"
  dato = Hash.new
  dato  = request.raw_post  
    puts "jtli entrante #{dato}"
    if User.exists?(:jti => dato)
     Rails.cache.write('PHnuverificado', 'existe') 
     @informacion = {resultado: 'existe'}
  else
    @informacion = {resultado: 'inexistente'}
      #Ex:- :null => false
  end
  render json: @informacion
end

#Verificar antes de eliminar

def verif_before_delete_half
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
def verif_before_see_half
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
    def set_half_payment
      @half_payment = HalfPayment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def half_payment_params
      params.require(:half_payment).permit(:mpnombre)
    end
end
