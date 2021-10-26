

class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]
  respond_to? :json
  def initialize
    @customers = {} # los clientes se van a almacenar en un hash
    @next_id = 1 # un consecutivo para asignarle a cada cliente
  end
  # GET /categories
  def index

    @categories = Category.all.order(:id)

    render json: @categories
  end

  # GET /categories/1
  def show


    render json: @category
  end


  #Buscar si existe el jti
  def verificador_jti
      puts "entra aqui"
      dato = Hash.new
      dato  = request.raw_post  
        puts "jtli entrante #{dato}"
        if User.exists?(:jti => dato)
         Rails.cache.write('verificado', 'existe') 
         @informacion = {resultado: 'existe'}
      else
        Rails.cache.write('inexistente', 'inexistente') 
        @informacion = {resultado: 'inexistente'}
          #Ex:- :null => false
      end
      render json: @informacion
    end


  # POST /categories
  def create 
  if  Rails.cache.read('verificado') == 'existe' 

    @category = Category.new(category_params)
    if @category.save
      Rails.cache.delete('verificado') || Rails.cache.delete('inexistente')

      render json: @category, status: :created, location: @category
    else
      render json: @category.errors, status: :not_found
    end
  else
    render json: {resive: 'no tiene permiso'}
  end
  puts "verificar si se borro #{Rails.cache.read('verificado')}"
  end
    
  # PATCH/PUT /categories/1
  def update
    puts Rails.cache.read('verificado')

      if @category.update(category_params)
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end

  end

  # DELETE /categories/1
  def destroy
    if  Rails.cache.read('verificado') == 'existe' 
      Rails.cache.delete('verificado') || Rails.cache.delete('inexistente')
    @category.destroy
    else
      render json: @category.errors, status: :unprocessable_entity

    end

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
