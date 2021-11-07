class DecreasesController < ApplicationController
  before_action :set_decrease, only: [:show, :update, :destroy]
  before_action :situacion_repetida, only:[:muestra_situaciones]


  #GET mostrar las situaciones
  def muestra_situaciones
    render json: @situaciones_guardadas
  end

  # GET /decreases
  def index
    @decreases = Decrease.all

    render json: @decreases, :include => [:product  ]
  end

  # GET /decreases/1
  def show
    render json: @decrease
  end

  # POST /decreases
  def create
    if Rails.cache.read('PDverificado') == 'existe'
      Rails.cache.delete('PDverificado')
    @decrease = Decrease.new(decrease_params)

    if @decrease.save
      render json: @decrease, status: :created, location: @decrease
    else
      render json: @decrease.errors, status: :unprocessable_entity
    end
  else
    render json: {resive: 'no tiene permiso'}

  end
  end

  # PATCH/PUT /decreases/1
  def update
    if Rails.cache.read('PDnuverificado') == 'existe' 
      Rails.cache.delete('PDnuverificado')
    if @decrease.update(decrease_params)
      render json: @decrease
    else
      render json: @decrease.errors, status: :unprocessable_entity
    end
  else
    render json: {resive: 'no tiene permiso'}

  end
  end

  # DELETE /decreases/1
  def destroy
    @decrease.destroy
  end
  def verif_befores_save_decrease
    puts "entra aqui"
    dato = Hash.new
    dato  = request.raw_post  
      puts "jtli entrante #{dato}"
      if User.exists?(:jti => dato)
       Rails.cache.write('PDverificado', 'existe') 
       @informacion = {resultado: 'existe'}
    else
      @informacion = {resultado: 'inexistente'}
        #Ex:- :null => false
    end
    render json: @informacion
  end
#Verificar antes de actualizar
def verif_before_update_decrease
  puts "entra aqui"
  dato = Hash.new
  dato  = request.raw_post  
    puts "jtli entrante #{dato}"
    if User.exists?(:jti => dato)
     Rails.cache.write('PDnuverificado', 'existe') 
     @informacion = {resultado: 'existe'}
  else
    @informacion = {resultado: 'inexistente'}
      #Ex:- :null => false
  end
  render json: @informacion
end

#Verificar antes de eliminar

def verif_before_delete_decrease
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
def verif_before_see_decrease
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
    def set_decrease
      @decrease = Decrease.find(params[:id])
    end
  # Buscar la cantidad de veces que se repite una situacion.
  def situacion_repetida
    situaciones = Decrease.all.select(:causaMrm, :unidadesMrm, :product_id, :solution_boolean)
    consumo = []
    no_factura = []
    quebrado = []
    vencido = []
    noresuelto = []
    siresuelto = []
    situaciones.includes(:product).each do |d|
        situaciones_mermas(d, consumo, no_factura, quebrado, vencido, noresuelto, siresuelto)
    end
      @situaciones_guardadas = [{Consumo: consumo.length}, {noFacutra: no_factura.length}, {quebrado: quebrado.length}, {vencido: vencido.length}, {noresuelto: noresuelto.length}, {siresuelto: siresuelto.length}]
  end

  #cantidad de cada situacion
  def situaciones_mermas(merma, consumo, factura, quebrado, vencido, noresuelto, siresuelto)
    case merma.causaMrm
    when "Consumo"
      consumo.push( merma.causaMrm)
    when "No, en factura"
      factura.push(merma.causaMrm)
    when "Quebrado o roto"
      quebrado.push(merma.causaMrm)
    when "Vencido"
      vencido.push(merma.causaMrm)

    else
      []
    end

    case merma.solution_boolean
    when false
      noresuelto.push(merma.solution_boolean)
    when true
      siresuelto.push(merma.solution_boolean)
    else
      []
    end

  end
  
    # Only allow a trusted parameter "white list" through.
    def decrease_params
      params.require(:decrease).permit(:categoriasMrm, :unidadesMrm, :causaMrm, :hora, :product_id, :user_id, :solution_boolean )
    end
end
