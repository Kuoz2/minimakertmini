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

    @decrease = Decrease.new(decrease_params)

    if @decrease.save
      render json: @decrease, status: :created, location: @decrease
    else
      render json: @decrease.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /decreases/1
  def update
    if @decrease.update(decrease_params)
      render json: @decrease
    else
      render json: @decrease.errors, status: :unprocessable_entity
    end
  end

  # DELETE /decreases/1
  def destroy
    @decrease.destroy
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
    case merma.causaMrm || merma.solution_boolean
    when "Consumo"
      consumo.push( merma.causaMrm)
    when "No, en factura"
      factura.push(merma.causaMrm)
    when "Quebrado o roto"
      quebrado.push(merma.causaMrm)
    when "Vencido"
      vencido.push(merma.causaMrm)
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
