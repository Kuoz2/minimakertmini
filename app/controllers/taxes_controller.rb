class TaxesController < ApplicationController
  before_action :set_tax, only: [:show, :update, :destroy]

  # GET /taxes
  def index
    @taxes = Tax.all

    render json: @taxes
  end

  # GET /taxes/1
  def show
    render json: @tax
  end

  # POST /taxes
  def create
    if Rails.cache.read('PTverificado') == 'existe'
      Rails.cache.delete('PTverificado')
    @tax = Tax.new(tax_params)

    if @tax.save
      render json: @tax, status: :created, location: @tax
    else
      render json: @tax.errors, status: :unprocessable_entity
    end
  else
    render json: {resive: 'no tiene permiso'}
    end
  end

  # PATCH/PUT /taxes/1
  def update
    if Rails.cache.read('Pnuverificado') =='existe' 
      Rails.cache.delete('Pnuverificado')
      if @tax.update(tax_params)
      render json: @tax
    else
      render json: @tax.errors, status: :unprocessable_entity
    end
  else
    render json: {resive: 'no tiene permiso'}

  end
  end

  # DELETE /taxes/1
  def destroy
    @tax.destroy
  end
  def verif_befores_save_taxe
    puts "entra aqui"
    dato = Hash.new
    dato  = request.raw_post  
      puts "jtli entrante #{dato}"
      if User.exists?(:jti => dato)
       Rails.cache.write('PTverificado', 'existe') 
       @informacion = {resultado: 'existe'}
    else
      @informacion = {resultado: 'inexistente'}
        #Ex:- :null => false
    end
    render json: @informacion
  end
#Verificar antes de actualizar
def verif_before_update_taxe
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

def verif_before_delete_taxe
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
def verif_before_see_taxe
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
    def set_tax
      @tax = Tax.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tax_params
      params.require(:tax).permit(:tnombre, :timpuesto)
    end
end
