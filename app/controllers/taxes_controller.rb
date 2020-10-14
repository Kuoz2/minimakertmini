class TaxesController < ApplicationController
  before_action :set_tax, only: [:show, :update, :destroy]

  # GET /taxes
  def index
    @taxes = Tax.all

    render json: @taxes
  end

  # GET /taxes/1
  def show
    render json: @tax
  end

  # POST /taxes
  def create
    @tax = Tax.new(tax_params)

    if @tax.save
      render json: @tax, status: :created, location: @tax
    else
      render json: @tax.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /taxes/1
  def update
    if @tax.update(tax_params)
      render json: @tax
    else
      render json: @tax.errors, status: :unprocessable_entity
    end
  end

  # DELETE /taxes/1
  def destroy
    @tax.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tax
      @tax = Tax.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tax_params
      params.require(:tax).permit(:tnombre, :timpuesto)
    end
end
