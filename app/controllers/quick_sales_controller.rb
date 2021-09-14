class QuickSalesController < ApplicationController
  before_action :set_quick_sale, only: [:show, :update, :destroy]

  # GET /quick_sales
  def index
    @quick_sales = QuickSale.all

    render json: @quick_sales
  end

  # GET /quick_sales/1
  def show
    render json: @quick_sale
  end

  # POST /quick_sales
  def create
    @quick_sale = QuickSale.new(quick_sale_params)

    if @quick_sale.save
      render json: @quick_sale, status: :created, location: @quick_sale
    else
      render json: @quick_sale.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /quick_sales/1
  def update
    if @quick_sale.update(quick_sale_params)
      render json: @quick_sale
    else
      render json: @quick_sale.errors, status: :unprocessable_entity
    end
  end

  # DELETE /quick_sales/1
  def destroy
    @quick_sale.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quick_sale
      @quick_sale = QuickSale.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def quick_sale_params
      params.require(:quick_sale).permit(:cod_product, :nombre_product, :fecha_venta, :cantidad, :medio_pago, :precio, :efectivo)
    end
end
