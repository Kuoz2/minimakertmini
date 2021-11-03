class ArchingsController < ApplicationController
  before_action :set_arching, only: [:show, :update, :destroy]

  # GET /archings
  def index
    @archings = Arching.all

    render json: @archings
  end

  # GET /archings/1
  def show
    render json: @arching
  end

  # POST /archings
  def create
    if  Rails.cache.read('PARCHverificado') == 'existe' 

    @arching = Arching.new(arching_params)

    if @arching.save
      render json: @arching, status: :created, location: @arching
    else
      render json: @arching.errors, status: :unprocessable_entity
    end
    else
      render json: {resive: 'no tiene permiso'}

    end
  end

  # PATCH/PUT /archings/1
  def update
    if @arching.update(arching_params)
      render json: @arching
    else
      render json: @arching.errors, status: :unprocessable_entity
    end
  end

  # DELETE /archings/1
  def destroy
    @arching.destroy
  end
  def verif_befores_save_arching
    puts "entra aqui"
    dato = Hash.new
    dato  = request.raw_post  
      puts "jtli entrante #{dato}"
      if User.exists?(:jti => dato)
       Rails.cache.write('PARCHverificado', 'existe') 
       @informacion = {resultado: 'existe'}
    else
      Rails.cache.write('PARCHverificado', 'inexistente') 
      @informacion = {resultado: 'inexistente'}
        #Ex:- :null => false
    end
    render json: @informacion
  end
#Verificar antes de actualizar
def verif_before_update_arching
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

def verif_before_delete_arching
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
def verif_before_see_arching
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
    def set_arching
      @arching = Arching.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def arching_params
      params.require(:arching).permit(:arhoraini, :arhoracier,:decrease_id,:voucher_id,:sale_id)
    end
end
