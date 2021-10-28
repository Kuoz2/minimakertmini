class DateExpirationsController < ApplicationController
  before_action :set_date_expiration, only: [:show, :update, :destroy]
  before_action :buscar_fecha_perdidas, only:[:buscar_las_fechas_perdidas]
  before_action :total_perdidas_inventario2, only:[:todaslasperdidasdos]
  # GET /date_expirations
  def index
    @date_expirations = DateExpiration.all.where(product_id: 0)

    render json: @date_expirations, :include => [:product =>{include: [:stock, :category, :brand]}]
  end

  def date_product_id_on
    @date_expiration = DateExpiration.all.where.not(product_id: 0 )
    render json: @date_expiration, :include => [:product => {include: [:stock, :category, :brand]}]
  end

  def todaslasperdidasdos()
      render json: {total_perdidas: @total_perdidasinv2}
  end

  def buscar_las_fechas_perdidas
    render :json => @prueba_stock_prod.group_by {|h| h.keys.first}.values.map{|a| {a.first.keys.first => a.inject(0){|sum, h| sum + h.values.first.to_i}.to_s}}
  end

  # GET /date_expirations/1
  def show
    render json: @date_expiration, include: [:product => {include: [:category, :brand, :stock]}]
  end

  # POST /date_expirations
  def create
    @date_expiration = DateExpiration.new(date_expiration_params)

    if @date_expiration.save
      render json: @date_expiration, status: :created, location: @date_expiration
    else
      render json: @date_expiration.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /date_expirations/1
  def update
    if @date_expiration.update(date_expiration_params)
      render json: @date_expiration
    else
      render json: @date_expiration.errors, status: :unprocessable_entity
    end
  end

  # DELETE /date_expirations/1
  def destroy
    @date_expiration.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_date_expiration
      @date_expiration = DateExpiration.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def date_expiration_params
      params.require(:date_expiration).permit(:fecha_vencimiento, :cambio_fecha, :cantidad_cambiadas, :stock_expiration , :product_id)
    end

    def cantidad_perdidas_pormes

    end

    def total_perdidas_inventario2
      @total_perdidasinv2 = DateExpiration.all.map(&:stock_expiration).reduce(:+) 
    end

    def buscar_fecha_perdidas
      data = []
      numero ||= []
      fecha = Time.zone.today.month
      jn = []
      #Primero tengo q rutiar las fechas que estan y no estan despues debo suplementar los numeros que estan con 0
     inicio = DateExpiration.all.
         filter{|a|
            if a.stock_expiration != 0
           method_name(a, data)
            end
          
         }.as_json(:only => [:stock_expiration, :created_at])
      #inicio.each_entry{|d| d.each_value { |b|data.push(b)  }}  
      @prueba_stock_prod  = data
      
    
  end

    def method_name(a, data)
      case a.created_at.to_s[5, 2].to_i
      when 1
        data.push({:Ene => a.stock_expiration})
      when 2
        data.push({:Feb =>a.stock_expiration})
      when 3
        data.push({:Marz => a.stock_expiration})
      when 4
        data.push({:Abr => a.stock_expiration})
      when 5
        data.push({:May => a.stock_expiration})
      when 6
        data.push({:Jun => a.stock_expiration})
      when 7
        data.push({:Jul => a.stock_expiration})
      when 8
        data.push({:Agos => a.stock_expiration})
      when 9
        data.push({:Sep => a.stock_expiration})
      when 10
        data.push({:Oct => a.stock_expiration})
      when 11
        data.push({:Nov => a.stock_expiration})
      when 12
        data.push({:Dis => a.stock_expiration})
      else
        []
      end
    end

end
