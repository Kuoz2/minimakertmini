require 'test_helper'

class DateExpirationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @date_expiration = date_expirations(:one)
  end

  test "should get index" do
    get date_expirations_url, as: :json
    assert_response :success
  end

  test "should create date_expiration" do
    assert_difference('DateExpiration.count') do
      post date_expirations_url, params: { date_expiration: { cambio_fecha: @date_expiration.cambio_fecha, cantidad_cambiadas: @date_expiration.cantidad_cambiadas, fecha_vencimiento: @date_expiration.fecha_vencimiento } }, as: :json
    end

    assert_response 201
  end

  test "should show date_expiration" do
    get date_expiration_url(@date_expiration), as: :json
    assert_response :success
  end

  test "should update date_expiration" do
    patch date_expiration_url(@date_expiration), params: { date_expiration: { cambio_fecha: @date_expiration.cambio_fecha, cantidad_cambiadas: @date_expiration.cantidad_cambiadas, fecha_vencimiento: @date_expiration.fecha_vencimiento } }, as: :json
    assert_response 200
  end

  test "should destroy date_expiration" do
    assert_difference('DateExpiration.count', -1) do
      delete date_expiration_url(@date_expiration), as: :json
    end

    assert_response 204
  end
end
