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
    if  Rails.cache.read('PARverificado') == 'existe' 

    @archive = Archive.new(archive_params)

    if @archive.save
      EnvioTicketMailer.new_envio_email(@archive).deliver
      render json: @archive, status: :created, location: @archive
    else
      render json: @archive.errors, status: :unprocessable_entity
    end
  else
    render json: {resive: 'no tiene permiso'}

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
  def verif_befores_save_archive
    puts "entra aqui"
    dato = Hash.new
    dato  = request.raw_post  
      puts "jtli entrante #{dato}"
      if User.exists?(:jti => dato)
       Rails.cache.write('PARverificado', 'existe') 
       @informacion = {resultado: 'existe'}
    else
      Rails.cache.write('PARverificado', 'inexistente') 
      @informacion = {resultado: 'inexistente'}
        #Ex:- :null => false
    end
    render json: @informacion
  end
#Verificar antes de actualizar
def verif_before_update_archive
  puts "entra aqui"
  dato = Hash.new
  dato  = request.raw_post  
    puts "jtli entrante #{dato}"
    if User.exists?(:jti => dato)
     Rails.cache.write('Pnuverificado', 'existe') 
     @informacion = {resultado: 'existe'}
  else
    Rails.cache.write('Pnuverificado', 'inexistente') 
    @informacion = {resultado: 'inexistente'}
      #Ex:- :null => false
  end
  render json: @informacion
end

#Verificar antes de eliminar

def verif_before_delete_archive
  puts "entra aqui"
  dato = Hash.new
  dato  = request.raw_post  
    puts "jtli entrante #{dato}"
    if User.exists?(:jti => dato)
     Rails.cache.write('Pndverificado', 'existe') 
     @informacion = {resultado: 'existe'}
  else
    Rails.cache.write('Pndverificado', 'inexistente') 
    @informacion = {resultado: 'inexistente'}
      #Ex:- :null => false
  end
  render json: @informacion
end

#Verificar si esta verificado para ver
def verif_before_see_archive
  puts "entra aqui"
  dato = Hash.new
  dato  = request.raw_post  
    puts "jtli entrante #{dato}"
    if User.exists?(:jti => dato)
     Rails.cache.write('Pnsverificado', 'existe') 
     @informacion = {resultado: 'existe'}
  else
    Rails.cache.write('Pnsverificado', 'inexistente') 
    @informacion = {resultado: 'inexistente'}
      #Ex:- :null => false
  end
  render json: @informacion
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
