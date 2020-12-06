class ConfigVouchersController < ApplicationController
  before_action :set_config_voucher, only: [:show, :update, :destroy]

  # GET /config_vouchers
  def index
    @config_vouchers = ConfigVoucher.all

    render json: @config_vouchers
  end

  # GET /config_vouchers/1
  def show
    render json: @config_voucher
  end

  # POST /config_vouchers
  def create
    @config_voucher = ConfigVoucher.new(config_voucher_params)

    if @config_voucher.save
      render json: @config_voucher, status: :created, location: @config_voucher
    else
      render json: @config_voucher.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /config_vouchers/1
  def update
    if @config_voucher.update(config_voucher_params)
      render json: @config_voucher
    else
      render json: @config_voucher.errors, status: :unprocessable_entity
    end
  end

  # DELETE /config_vouchers/1
  def destroy
    @config_voucher.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_config_voucher
      @config_voucher = ConfigVoucher.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def config_voucher_params
      params.require(:config_voucher).permit(:bdte, :bcantidad, :bemitidas, :bexistentes)
    end
end
