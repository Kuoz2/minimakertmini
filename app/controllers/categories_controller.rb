

class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]
  respond_to? :json
  def initialize
    @customers = {} # los clientes se van a almacenar en un hash
    @next_id = 1 # un consecutivo para asignarle a cada cliente
  end
  # GET /categories
  def index
    
    @categories = Category.all.order(id: :desc)
    
    render json: @categories

  end

  # GET /categories/1
  def show


    render json: @category
  end

  def verificar_blank_category
    @estavacio = Category.all.blank?
    render json: @estavacio
  end
  


  # POST /categories
  def create 
    
  if  Rails.cache.read('PCAverificado') == 'existe' 
   Rails.cache.delete('PCAverificado') 

    @category = Category.new(category_params)
    if @category.save

      render json: {respuesta: "correctamente"}, status: :created, location: @category
    else
      render json: @category.errors, status: :not_found
    end
 else
  render json: {resive: 'no tiene permiso'}
 end
  end
    
  # PATCH/PUT /categories/1
  def update
    if Rails.cache.read('PCAnuverificado' ) == 'existe'
      Rails.cache.delete('PCAnuverificado' )
      if @category.update(category_params)
      render json: {actualizado: 'correctamente'}
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  else
    render json: {resive: 'no tiene permiso'}

  end

  end

  # DELETE /categories/1
  def destroy
    if  Rails.cache.read('Pndeverificado') == 'existe' 
      Rails.cache.delete('Pndeverificado') 
      @category.destroy

    else
      render json: @category.errors, status: :unprocessable_entity

    end

  end
  def verif_save_category
    puts "entra aqui"
    dato  = request.raw_post  
      puts "jtli entrante #{dato}"
      if User.exists?(:jti => dato)
       Rails.cache.write('PCAverificado', 'existe') 
       @informacion = {resultado: 'existe'}
    else
      @informacion = {resultado: 'inexistente'}
        #Ex:- :null => false
    end
    render json: @informacion
  end
#Verificar antes de actualizar
def verif_before_update_category
  puts "entra aqui"
  dato = Hash.new
  dato  = request.raw_post  
    puts "jtli entrante #{dato}"
    if User.exists?(:jti => dato)
     Rails.cache.write('PCAnuverificado', 'existe') 
     @informacion = {resultado: 'existe'}
  else
    @informacion = {resultado: 'inexistente'}
      #Ex:- :null => false
  end
  render json: @informacion
end

#Verificar antes de eliminar

def verif_before_delete_category
  puts "entra aqui"
  dato = Hash.new
  dato  = request.raw_post  
    puts "jtli entrante #{dato}"
    if User.exists?(:jti => dato)
     Rails.cache.write('Pndeverificado', 'existe') 
     @informacion = {resultado: 'existe'}
  else
    Rails.cache.write('Pndeverificado', 'inexistente') 
    @informacion = {resultado: 'inexistente'}
      #Ex:- :null => false
  end
  render json: @informacion
end

#Verificar si esta verificado para ver
def verif_before_see_category
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
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:cnombre)
    end

   
end
