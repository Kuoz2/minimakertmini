require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get products_url, as: :json
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post products_url, params: { product: { brand_id: @product.brand_id, category_id: @product.category_id, pcodigo: @product.pcodigo, pdescripcion: @product.pdescripcion, pdetalle: @product.pdetalle, ppicture: @product.ppicture, pstock: @product.pstock, pstockcatalogo: @product.pstockcatalogo, pvactivacioncatalogo: @product.pvactivacioncatalogo, pvalor: @product.pvalor } }, as: :json
    end

    assert_response 201
  end

  test "should show product" do
    get product_url(@product), as: :json
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: { brand_id: @product.brand_id, category_id: @product.category_id, pcodigo: @product.pcodigo, pdescripcion: @product.pdescripcion, pdetalle: @product.pdetalle, ppicture: @product.ppicture, pstock: @product.pstock, pstockcatalogo: @product.pstockcatalogo, pvactivacioncatalogo: @product.pvactivacioncatalogo, pvalor: @product.pvalor } }, as: :json
    assert_response 200
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete product_url(@product), as: :json
    end

    assert_response 204
  end
end
