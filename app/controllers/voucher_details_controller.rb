class VoucherDetailsController < ApplicationController
  before_action :set_voucher_detail, only: [:show, :update, :destroy]

  # GET /voucher_details
  def index
    @voucher_details = VoucherDetail.all

    render json: @voucher_details, :include => [:voucher, :product]
  end

  # GET /voucher_details/1
  def show
    render json: @voucher_detail
  end
  # POST /voucher_details
  def create
    @voucher =  Voucher.new(params.permit![:voucher_id])
    @voucher_detail = @voucher.voucher_details.new(voucher_detail_params)
    if @voucher_detail.save
    render json: @voucher_detail, status: :created, location: @voucher_detail
    else
    render json: @voucher_detail.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /voucher_details/1
  def update
    if @voucher_detail.update(voucher_detail_params)
      render json: @voucher_detail
    else
      render json: @voucher_detail.errors, status: :unprocessable_entity
    end
  end

  # DELETE /voucher_details/1
  def destroy
    @voucher_detail.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_voucher_detail
    @voucher_detail = VoucherDetail.find(params[:id])
  end


    # Only allow a trusted parameter "white list" through.
  def voucher_detail_params
    params.require(:voucher_detail).permit(:dvcantidad,
                                           :dvprecio,
                                           {:voucher_id => [:vtotal,:vnumerodebusqueda]},
                                           :product_id)
  end
end
