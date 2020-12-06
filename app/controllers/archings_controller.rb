class ArchingsController < ApplicationController
  before_action :set_arching, only: [:show, :update, :destroy]

  # GET /archings
  def index
    @archings = Arching.all

    render json: @archings
  end

  # GET /archings/1
  def show
    render json: @arching
  end

  # POST /archings
  def create
    @arching = Arching.new(arching_params)

    if @arching.save
      render json: @arching, status: :created, location: @arching
    else
      render json: @arching.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /archings/1
  def update
    if @arching.update(arching_params)
      render json: @arching
    else
      render json: @arching.errors, status: :unprocessable_entity
    end
  end

  # DELETE /archings/1
  def destroy
    @arching.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_arching
      @arching = Arching.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def arching_params
      params.require(:arching).permit(:arhoraini, :arhoracier,:decrease_id,:voucher_id,:sale_id)
    end
end
