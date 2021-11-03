class MrmsolutionsController < ApplicationController
  before_action :set_mrmsolution, only: [:show, :update, :destroy]


  # GET /mrmsolutions
  def index
    @mrmsolutions = Mrmsolution.all

    render json: @mrmsolutions
  end


  # GET /mrmsolutions/1
  def show
    render json: @mrmsolution
  end

  # POST /mrmsolutions
  def create
    if Rails.cache.read('PMverificado') == 'existe'

    @mrmsolution = Mrmsolution.new(mrmsolution_params)

    if @mrmsolution.save
      render json: @mrmsolution, status: :created, location: @mrmsolution
    else
      render json: @mrmsolution.errors, status: :unprocessable_entity
    end
  else
    render json: {resive: 'no tiene permiso'}

  end
  end

  # PATCH/PUT /mrmsolutions/1
  def update
    if @mrmsolution.update(mrmsolution_params)
      render json: @mrmsolution
    else
      render json: @mrmsolution.errors, status: :unprocessable_entity
    end
  end

  # DELETE /mrmsolutions/1
  def destroy
    @mrmsolution.destroy
  end
  def verif_befores_save_solution
    puts "entra aqui"
    dato = Hash.new
    dato  = request.raw_post  
      puts "jtli entrante #{dato}"
      if User.exists?(:jti => dato)
       Rails.cache.write('PMverificado', 'existe') 
       @informacion = {resultado: 'existe'}
    else
      Rails.cache.write('PMverificado', 'inexistente') 
      @informacion = {resultado: 'inexistente'}
        #Ex:- :null => false
    end
    render json: @informacion
  end
#Verificar antes de actualizar
def verif_before_update_solution
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

def verif_before_delete_solution
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
def verif_before_see_solution
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
    def set_mrmsolution
      @mrmsolution = Mrmsolution.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def mrmsolution_params
      params.require(:mrmsolution).permit(:mrmsolucion, :mrmfechasolucion, :cantidad_veces_cometido, :decrease_id)
    end
end
