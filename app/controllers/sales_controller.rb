class SalesController < ApplicationController
  before_action :sales_params, only: [:show]

  def index

    @sales = Sale.all

    render json: @sales

  end

  def show
    render json: @sale
  end


  def create
    @paymet = Payment.new(params.permit![:payment_id ])
    @sale = @paymet.sales.new(sales_params)
    if @sale.save
      render json: @sale, status: :created, location: @sale
    else
      render json: @sale.errors, status: :unprocessable_entity
    end
  end

  private
  def get_sale
    @sale = Sale.find(params[:id])
  end

  def sales_params
    params.require(:sale).permit(
        {:payment_id =>[:pagomonto,:pagovuelto,:half_payment_id ]},
        :voucher_id)
  end
end
