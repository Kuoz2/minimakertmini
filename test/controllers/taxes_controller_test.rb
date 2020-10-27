require 'test_helper'

class TaxesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tax = taxes(:one)
  end

  test "should get index" do
    get taxes_url, as: :json
    assert_response :success
  end

  test "should create tax" do
    assert_difference('Tax.count') do
      post taxes_url, params: { tax: { timpuesto: @tax.timpuesto, tnombre: @tax.tnombre } }, as: :json
    end

    assert_response 201
  end

  test "should show tax" do
    get tax_url(@tax), as: :json
    assert_response :success
  end

  test "should update tax" do
    patch tax_url(@tax), params: { tax: { timpuesto: @tax.timpuesto, tnombre: @tax.tnombre } }, as: :json
    assert_response 200
  end

  test "should destroy tax" do
    assert_difference('Tax.count', -1) do
      delete tax_url(@tax), as: :json
    end

    assert_response 204
  end
end
