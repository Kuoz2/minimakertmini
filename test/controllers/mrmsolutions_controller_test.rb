require 'test_helper'

class MrmsolutionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mrmsolution = mrmsolutions(:one)
  end

  test "should get index" do
    get mrmsolutions_url, as: :json
    assert_response :success
  end

  test "should create mrmsolution" do
    assert_difference('Mrmsolution.count') do
      post mrmsolutions_url, params: { mrmsolution: { cantidad_veces_cometido: @mrmsolution.cantidad_veces_cometido, mrmfechasolucion: @mrmsolution.mrmfechasolucion, mrmsolucion: @mrmsolution.mrmsolucion } }, as: :json
    end

    assert_response 201
  end

  test "should show mrmsolution" do
    get mrmsolution_url(@mrmsolution), as: :json
    assert_response :success
  end

  test "should update mrmsolution" do
    patch mrmsolution_url(@mrmsolution), params: { mrmsolution: { cantidad_veces_cometido: @mrmsolution.cantidad_veces_cometido, mrmfechasolucion: @mrmsolution.mrmfechasolucion, mrmsolucion: @mrmsolution.mrmsolucion } }, as: :json
    assert_response 200
  end

  test "should destroy mrmsolution" do
    assert_difference('Mrmsolution.count', -1) do
      delete mrmsolution_url(@mrmsolution), as: :json
    end

    assert_response 204
  end
end
