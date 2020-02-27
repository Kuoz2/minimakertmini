require 'test_helper'

class VoucherDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @voucher_detail = voucher_details(:one)
  end

  test "should get index" do
    get voucher_details_url, as: :json
    assert_response :success
  end

  test "should create voucher_detail" do
    assert_difference('VoucherDetail.count') do
      post voucher_details_url, params: { voucher_detail: { dvcantidad: @voucher_detail.dvcantidad, dvprecio: @voucher_detail.dvprecio, product_id: @voucher_detail.product_id, voucher_id: @voucher_detail.voucher_id } }, as: :json
    end

    assert_response 201
  end

  test "should show voucher_detail" do
    get voucher_detail_url(@voucher_detail), as: :json
    assert_response :success
  end

  test "should update voucher_detail" do
    patch voucher_detail_url(@voucher_detail), params: { voucher_detail: { dvcantidad: @voucher_detail.dvcantidad, dvprecio: @voucher_detail.dvprecio, product_id: @voucher_detail.product_id, voucher_id: @voucher_detail.voucher_id } }, as: :json
    assert_response 200
  end

  test "should destroy voucher_detail" do
    assert_difference('VoucherDetail.count', -1) do
      delete voucher_detail_url(@voucher_detail), as: :json
    end

    assert_response 204
  end
end
