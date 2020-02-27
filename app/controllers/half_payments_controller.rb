class HalfPaymentsController < ApplicationController
  before_action :set_half_payment, only: [:show, :update, :destroy]

  # GET /half_payments
  def index
    @half_payments = HalfPayment.all

    render json: @half_payments
  end

  # GET /half_payments/1
  def show
    render json: @half_payment
  end

  # POST /half_payments
  def create
    @half_payment = HalfPayment.new(half_payment_params)

    if @half_payment.save
      render json: @half_payment, status: :created, location: @half_payment
    else
      render json: @half_payment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /half_payments/1
  def update
    if @half_payment.update(half_payment_params)
      render json: @half_payment
    else
      render json: @half_payment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /half_payments/1
  def destroy
    @half_payment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_half_payment
      @half_payment = HalfPayment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def half_payment_params
      params.require(:half_payment).permit(:mpnombre)
    end
end
