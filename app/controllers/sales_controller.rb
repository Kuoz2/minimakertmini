class SalesController < ApplicationController
  before_action :sales_params, only: [:show]

  def index

    @sales = Sale.all

    render json: @sales

  end

  def show
    render json: @sale
  end


  def create
    if Rails.cache.read('PSAverificado') == 'existe'

    @paymet = Payment.new(params.permit![:payment_id ])
    @sale = @paymet.sales.new(sales_params)
    if @sale.save
      render json: @sale, status: :created, location: @sale
    else
      render json: @sale.errors, status: :unprocessable_entity
    end
  else
    render json: {resive: 'no tiene permiso'}
  end
  end
  def verif_befores_save_sales
    puts "entra aqui"
    dato = Hash.new
    dato  = request.raw_post  
      puts "jtli entrante #{dato}"
      if User.exists?(:jti => dato)
       Rails.cache.write('PSAverificado', 'existe') 
       @informacion = {resultado: 'existe'}
    else
      Rails.cache.write('PSAverificado', 'inexistente') 
      @informacion = {resultado: 'inexistente'}
        #Ex:- :null => false
    end
    render json: @informacion
  end
#Verificar antes de actualizar
def verif_before_update_sales
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

def verif_before_delete_sales
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
def verif_before_see_sales
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
  def get_sale
    @sale = Sale.find(params[:id])
  end

  def sales_params
    params.require(:sale).permit(
        {:payment_id =>[:pagomonto,:pagovuelto,:half_payment_id ]},
        :voucher_id, :user_id)
  end
end
