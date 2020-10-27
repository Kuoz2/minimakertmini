require 'test_helper'

class ProvidersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @provider = providers(:one)
  end

  test "should get index" do
    get providers_url, as: :json
    assert_response :success
  end

  test "should create provider" do
    assert_difference('Provider.count') do
      post providers_url, params: { provider: { banco_provider: @provider.banco_provider, ciudad_provider: @provider.ciudad_provider, codigo_provider: @provider.codigo_provider, comuna_provider: @provider.comuna_provider, concepto_gasto_provider: @provider.concepto_gasto_provider, contabilidad_provider: @provider.contabilidad_provider, correo_provider: @provider.correo_provider, direccion_provider: @provider.direccion_provider, factura_provider: @provider.factura_provider, formadepago_provider: @provider.formadepago_provider, gasto_provider: @provider.gasto_provider, nip_provider: @provider.nip_provider, nombre_provider: @provider.nombre_provider, plazo_provider: @provider.plazo_provider, telefono_persona_provider: @provider.telefono_persona_provider, telefono_provider: @provider.telefono_provider } }, as: :json
    end

    assert_response 201
  end

  test "should show provider" do
    get provider_url(@provider), as: :json
    assert_response :success
  end

  test "should update provider" do
    patch provider_url(@provider), params: { provider: { banco_provider: @provider.banco_provider, ciudad_provider: @provider.ciudad_provider, codigo_provider: @provider.codigo_provider, comuna_provider: @provider.comuna_provider, concepto_gasto_provider: @provider.concepto_gasto_provider, contabilidad_provider: @provider.contabilidad_provider, correo_provider: @provider.correo_provider, direccion_provider: @provider.direccion_provider, factura_provider: @provider.factura_provider, formadepago_provider: @provider.formadepago_provider, gasto_provider: @provider.gasto_provider, nip_provider: @provider.nip_provider, nombre_provider: @provider.nombre_provider, plazo_provider: @provider.plazo_provider, telefono_persona_provider: @provider.telefono_persona_provider, telefono_provider: @provider.telefono_provider } }, as: :json
    assert_response 200
  end

  test "should destroy provider" do
    assert_difference('Provider.count', -1) do
      delete provider_url(@provider), as: :json
    end

    assert_response 204
  end
end
