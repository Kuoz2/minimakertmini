require 'test_helper'

class DecreasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @decrease = decreases(:one)
  end

  test "should get index" do
    get decreases_url, as: :json
    assert_response :success
  end

  test "should create decrease" do
    assert_difference('Decrease.count') do
      post decreases_url, params: { decrease: { mcodigo: @decrease.mcodigo, mproducto: @decrease.mproducto, munidades: @decrease.munidades } }, as: :json
    end

    assert_response 201
  end

  test "should show decrease" do
    get decrease_url(@decrease), as: :json
    assert_response :success
  end

  test "should update decrease" do
    patch decrease_url(@decrease), params: { decrease: { mcodigo: @decrease.mcodigo, mproducto: @decrease.mproducto, munidades: @decrease.munidades } }, as: :json
    assert_response 200
  end

  test "should destroy decrease" do
    assert_difference('Decrease.count', -1) do
      delete decrease_url(@decrease), as: :json
    end

    assert_response 204
  end
end
