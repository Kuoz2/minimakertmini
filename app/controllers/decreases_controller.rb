class DecreasesController < ApplicationController
  before_action :set_decrease, only: [:show, :update, :destroy]

  # GET /decreases
  def index
    @decreases = Decrease.all

    render json: @decreases
  end

  # GET /decreases/1
  def show
    render json: @decrease
  end

  # POST /decreases
  def create
    @decrease = Decrease.new(decrease_params)

    if @decrease.save
      render json: @decrease, status: :created, location: @decrease
    else
      render json: @decrease.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /decreases/1
  def update
    if @decrease.update(decrease_params)
      render json: @decrease
    else
      render json: @decrease.errors, status: :unprocessable_entity
    end
  end

  # DELETE /decreases/1
  def destroy
    @decrease.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_decrease
      @decrease = Decrease.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def decrease_params
      params.require(:decrease).permit(:mproducto, :mcodigo, :munidades, :product_id)
    end
end
