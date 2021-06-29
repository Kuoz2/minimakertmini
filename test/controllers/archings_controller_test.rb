require 'test_helper'

class ArchingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @arching = archings(:one)
  end

  test "should get index" do
    get archings_url, as: :json
    assert_response :success
  end

  test "should create arching" do
    assert_difference('Arching.count') do
      post archings_url, params: { arching: { arhoracier: @arching.arhoracier, arhoraini: @arching.arhoraini } }, as: :json
    end

    assert_response 201
  end

  test "should show arching" do
    get arching_url(@arching), as: :json
    assert_response :success
  end

  test "should update arching" do
    patch arching_url(@arching), params: { arching: { arhoracier: @arching.arhoracier, arhoraini: @arching.arhoraini } }, as: :json
    assert_response 200
  end

  test "should destroy arching" do
    assert_difference('Arching.count', -1) do
      delete arching_url(@arching), as: :json
    end

    assert_response 204
  end
end
