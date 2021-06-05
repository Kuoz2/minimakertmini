class MrmsolutionsController < ApplicationController
  before_action :set_mrmsolution, only: [:show, :update, :destroy]


  # GET /mrmsolutions
  def index
    @mrmsolutions = Mrmsolution.all

    render json: @mrmsolutions
  end


  # GET /mrmsolutions/1
  def show
    render json: @mrmsolution
  end

  # POST /mrmsolutions
  def create
    @mrmsolution = Mrmsolution.new(mrmsolution_params)

    if @mrmsolution.save
      render json: @mrmsolution, status: :created, location: @mrmsolution
    else
      render json: @mrmsolution.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /mrmsolutions/1
  def update
    if @mrmsolution.update(mrmsolution_params)
      render json: @mrmsolution
    else
      render json: @mrmsolution.errors, status: :unprocessable_entity
    end
  end

  # DELETE /mrmsolutions/1
  def destroy
    @mrmsolution.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mrmsolution
      @mrmsolution = Mrmsolution.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def mrmsolution_params
      params.require(:mrmsolution).permit(:mrmsolucion, :mrmfechasolucion, :cantidad_veces_cometido, :decrease_id)
    end
end
