require 'test_helper'

class HalfPaymentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @half_payment = half_payments(:one)
  end

  test "should get index" do
    get half_payments_url, as: :json
    assert_response :success
  end

  test "should create half_payment" do
    assert_difference('HalfPayment.count') do
      post half_payments_url, params: { half_payment: { mpnombre: @half_payment.mpnombre } }, as: :json
    end

    assert_response 201
  end

  test "should show half_payment" do
    get half_payment_url(@half_payment), as: :json
    assert_response :success
  end

  test "should update half_payment" do
    patch half_payment_url(@half_payment), params: { half_payment: { mpnombre: @half_payment.mpnombre } }, as: :json
    assert_response 200
  end

  test "should destroy half_payment" do
    assert_difference('HalfPayment.count', -1) do
      delete half_payment_url(@half_payment), as: :json
    end

    assert_response 204
  end
end
