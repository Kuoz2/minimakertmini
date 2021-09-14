require 'test_helper'

class QuickSalesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @quick_sale = quick_sales(:one)
  end

  test "should get index" do
    get quick_sales_url, as: :json
    assert_response :success
  end

  test "should create quick_sale" do
    assert_difference('QuickSale.count') do
      post quick_sales_url, params: { quick_sale: { cantidad: @quick_sale.cantidad, cod_product: @quick_sale.cod_product, efectivo: @quick_sale.efectivo, fecha_venta: @quick_sale.fecha_venta, medio_pago: @quick_sale.medio_pago, nombre_product: @quick_sale.nombre_product, precio: @quick_sale.precio } }, as: :json
    end

    assert_response 201
  end

  test "should show quick_sale" do
    get quick_sale_url(@quick_sale), as: :json
    assert_response :success
  end

  test "should update quick_sale" do
    patch quick_sale_url(@quick_sale), params: { quick_sale: { cantidad: @quick_sale.cantidad, cod_product: @quick_sale.cod_product, efectivo: @quick_sale.efectivo, fecha_venta: @quick_sale.fecha_venta, medio_pago: @quick_sale.medio_pago, nombre_product: @quick_sale.nombre_product, precio: @quick_sale.precio } }, as: :json
    assert_response 200
  end

  test "should destroy quick_sale" do
    assert_difference('QuickSale.count', -1) do
      delete quick_sale_url(@quick_sale), as: :json
    end

    assert_response 204
  end
end
