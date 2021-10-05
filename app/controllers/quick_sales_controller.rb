class QuickSalesController < ApplicationController
  before_action :set_quick_sale, only: [:show, :update, :destroy]
  before_action :buscar_fecha_perdidas, only: [:ventarapida_fechas]
  before_action :totalventasrapdias, only:[:totalventasrapidas]
  # GET /quick_sales
  def index
    @quick_sales = QuickSale.all

    render json: @quick_sales
  end

  # GET /quick_sales/1
  def show
    render json: @quick_sale
  end

  def totalventasrapidas
    render json: {totalventasR:  @totalventasrapidas }
  end

  # POST /quick_sales
  def create
    @quick_sale = QuickSale.new(quick_sale_params)

    if @quick_sale.save
      render json: @quick_sale, status: :created, location: @quick_sale
    else
      render json: @quick_sale.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /quick_sales/1
  def update
    if @quick_sale.update(quick_sale_params)
      render json: @quick_sale
    else
      render json: @quick_sale.errors, status: :unprocessable_entity
    end
  end

  # DELETE /quick_sales/1
  def destroy
    @quick_sale.destroy
  end

  def ventarapida_fechas
  render json: @ventarapida_fechas  
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quick_sale
      @quick_sale = QuickSale.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def quick_sale_params
      params.require(:quick_sale).permit(:cod_product, :nombre_product, :fecha_venta, :cantidad, :medio_pago, :precio, :efectivo)
    end

    def totalventasrapdias
      @totalventasrapidas = QuickSale.all.map(&:precio).reduce(:+) 
    end

    def buscar_fecha_perdidas
      data = []
      numero ||= []
      fecha = Time.zone.today.month
      jn = []
      #Primero tengo q rutiar las fechas que estan y no estan despues debo suplementar los numeros que estan con 0
     inicio = QuickSale.all.
         filter{|a|
          if a.precio != 0
          method_name(a, data)
          end
         }

         @ventarapida_fechas  = data         
   
  end

    def method_name(a, data)
      case a.created_at.to_s[5, 2].to_i
      when 1
        data.push({:Ene => a.precio})
      when 2
        data.push({:Feb =>a.precio})
      when 3
        data.push({:Marz => a.precio})
      when 4
        data.push({:Abr => a.precio})
      when 5
        data.push({:May => a.precio})
      when 6
        data.push({:Jun => a.precio})
      when 7
        data.push({:Jul => a.precio})
      when 8
        data.push({:Agos => a.precio})
      when 9
        data.push({:Sep => a.precio})
      when 10
        data.push({:Oct => a.precio})
      when 11
        data.push({:Nov => a.precio})
      when 12
        data.push({:Dis => a.precio})
      else
        []
      end
  
     
    end
end
