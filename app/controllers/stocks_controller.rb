class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :update, :destroy]
  before_action :stock_perdida_este_mes, only: [:mostrar_stock_de_perdidas]

  # GET /stocks
  def index
    @stocks = Stock.all

    render json: @stocks
  end

  def mostrat_todos
    @list_stock = Stock.all
    render json: @list_stock
  end

  def mostrar_stock_de_perdidas
    render :json =>  @perdida_stock_anterior
  end

  # GET /stocks/1
  def show
    render json: @stock
  end

  # POST /stocks
  def create
    @stock = Stock.new(stock_params)

    if @stock.save
      render json: @stock, status: :created, location: @stock
    else
      render json: @stock.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stocks/1
  def update
    if @stock.update(stock_params)
      render json: @stock
    else
      render json: @stock.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stocks/1
  def destroy
    @stock.destroy
  end

  private

    #Mostrar solamente las perdidas de este mes.
    def stock_perdida_este_mes
      #Fecha actual en la que estamos.
          fecha = Time.zone.today.month
      nueva_fecha = fecha

      @perdida_stock_anterior = Stock.all.filter{|sa| sa.created_at.to_s[6,1] == nueva_fecha.to_s}.map(&:stock_lost).reduce(:+)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def stock_params
      params.require(:stock).permit(:pstock,:pstockcatalogo,:stock_lost,:stock_security)
    end
end
