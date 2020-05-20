class VouchersController < ApplicationController
  before_action :set_voucher, only: [:show, :update, :destroy]

  # GET /vouchers
  def index
    @vouchers = Voucher.all

    render json: @vouchers, :include => [:voucher_details]
  end

  # GET /vouchers/1
  def show
    render json: @voucher
  end

  # POST /vouchers
  def create
    @voucher = Voucher.new(voucher_params)
    if @voucher.save
      render json: @voucher, status: :created, location: @voucher
    else
      render json: @voucher.errors, status: :unprocessable_entity
    end
  end

  def showlast
    @voucher_last = Voucher.last
    render json: @voucher_last
  end

  # PATCH/PUT /vouchers/1
  def update
    if @voucher.update(voucher_params)
      render json: @voucher
    else
      render json: @voucher.errors, status: :unprocessable_entity
    end
  end

  # DELETE /vouchers/1
  def destroy
    @voucher.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_voucher
      @voucher = Voucher.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def voucher_params
      params.require(:voucher).permit(:vnumerodebusqueda, :vtotal)
    end
end
