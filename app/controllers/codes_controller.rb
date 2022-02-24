class CodesController < ApplicationController
  before_action :set_code, only: [:show, :update, :destroy]

  # GET /codes
  def index
    @codes = Code.all

    render json: @codes, :include =>[:product => {:include => [:category]}]
  end

  # GET /codes/1
  def show
    render json: @code
  end

  # POST /codes
  def create
    @code = Code.new(code_params)

    if @code.save
      render json: @code, status: :created, location: @code
    else
      render json: @code.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /codes/1
  def update
    if @code.update(code_params)
      render json: @code
    else
      render json: @code.errors, status: :unprocessable_entity
    end
  end

  # DELETE /codes/1
  def destroy
    @code.destroy
  end

  def last_code
    @codes = Code.all

    render json: @codes.last
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_code
      @code = Code.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def code_params
      params.require(:code).permit(:hora_emision, :product_id, :cod_market, :market, :panaderia, :cod_panaderia)
    end
end
