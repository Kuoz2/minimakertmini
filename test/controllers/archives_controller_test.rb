require 'test_helper'

class ArchivesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @archive = archives(:one)
  end

  test "should get index" do
    get archives_url, as: :json
    assert_response :success
  end

  test "should create archive" do
    assert_difference('Archive.count') do
      post archives_url, params: { archive: { nombreXML: @archive.nombreXML } }, as: :json
    end

    assert_response 201
  end

  test "should show archive" do
    get archive_url(@archive), as: :json
    assert_response :success
  end

  test "should update archive" do
    patch archive_url(@archive), params: { archive: { nombreXML: @archive.nombreXML } }, as: :json
    assert_response 200
  end

  test "should destroy archive" do
    assert_difference('Archive.count', -1) do
      delete archive_url(@archive), as: :json
    end

    assert_response 204
  end
end
