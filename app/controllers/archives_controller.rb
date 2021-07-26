class ArchivesController < ApplicationController
  before_action :set_archive, only: [:show, :update, :destroy]

  # GET /archives
  def index
    @archives = Archive.all

    render json: @archives
  end

  # GET /archives/1
  def show
    render json: @archive
  end

  # POST /archives
  def create
    @archive = Archive.new(archive_params)

    if @archive.save
      ApplicationMailer.new_envio_email.delivery
      render json: @archive, status: :created, location: @archive
    else
      render json: @archive.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /archives/1
  def update
    if @archive.update(archive_params)
      render json: @archive
    else
      render json: @archive.errors, status: :unprocessable_entity
    end
  end

  # DELETE /archives/1
  def destroy
    @archive.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_archive
      @archive = Archive.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def archive_params
      params.require(:archive).permit(:nombreXML)
    end
end
