require 'test_helper'

class ConfigVouchersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @config_voucher = config_vouchers(:one)
  end

  test "should get index" do
    get config_vouchers_url, as: :json
    assert_response :success
  end

  test "should create config_voucher" do
    assert_difference('ConfigVoucher.count') do
      post config_vouchers_url, params: { config_voucher: { bcantidad: @config_voucher.bcantidad, bdte: @config_voucher.bdte, bemitidas: @config_voucher.bemitidas } }, as: :json
    end

    assert_response 201
  end

  test "should show config_voucher" do
    get config_voucher_url(@config_voucher), as: :json
    assert_response :success
  end

  test "should update config_voucher" do
    patch config_voucher_url(@config_voucher), params: { config_voucher: { bcantidad: @config_voucher.bcantidad, bdte: @config_voucher.bdte, bemitidas: @config_voucher.bemitidas } }, as: :json
    assert_response 200
  end

  test "should destroy config_voucher" do
    assert_difference('ConfigVoucher.count', -1) do
      delete config_voucher_url(@config_voucher), as: :json
    end

    assert_response 204
  end
end
