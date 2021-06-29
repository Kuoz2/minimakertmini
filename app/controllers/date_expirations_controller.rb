class DateExpirationsController < ApplicationController
  before_action :set_date_expiration, only: [:show, :update, :destroy]

  # GET /date_expirations
  def index
    @date_expirations = DateExpiration.all.where(product_id: 0)

    render json: @date_expirations, :include => [:product]
  end

  def date_product_id_on
    @date_expiration = DateExpiration.all.where.not(product_id: 0 )
    render json: @date_expiration, :include => [:product => {include: [:stock, :category, :brand]}]
  end

  # GET /date_expirations/1
  def show
    render json: @date_expiration, include: [:product => {include: [:category, :brand, :stock]}]
  end

  # POST /date_expirations
  def create
    @date_expiration = DateExpiration.new(date_expiration_params)

    if @date_expiration.save
      render json: @date_expiration, status: :created, location: @date_expiration
    else
      render json: @date_expiration.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /date_expirations/1
  def update
    if @date_expiration.update(date_expiration_params)
      render json: @date_expiration
    else
      render json: @date_expiration.errors, status: :unprocessable_entity
    end
  end

  # DELETE /date_expirations/1
  def destroy
    @date_expiration.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_date_expiration
      @date_expiration = DateExpiration.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def date_expiration_params
      params.require(:date_expiration).permit(:fecha_vencimiento, :cambio_fecha, :cantidad_cambiadas, :stock_expiration ,:stock_expiration, :product_id)
    end
end
