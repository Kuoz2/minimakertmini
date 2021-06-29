require 'test_helper'

class MrmSolutionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mrm_solution = mrm_solutions(:one)
  end

  test "should get index" do
    get mrm_solutions_url, as: :json
    assert_response :success
  end

  test "should create mrm_solution" do
    assert_difference('MrmSolution.count') do
      post mrm_solutions_url, params: { mrm_solution: { cantidad_veces_cometido: @mrm_solution.cantidad_veces_cometido, mrmfechasolucion: @mrm_solution.mrmfechasolucion, mrmsolucion: @mrm_solution.mrmsolucion } }, as: :json
    end

    assert_response 201
  end

  test "should show mrm_solution" do
    get mrm_solution_url(@mrm_solution), as: :json
    assert_response :success
  end

  test "should update mrm_solution" do
    patch mrm_solution_url(@mrm_solution), params: { mrm_solution: { cantidad_veces_cometido: @mrm_solution.cantidad_veces_cometido, mrmfechasolucion: @mrm_solution.mrmfechasolucion, mrmsolucion: @mrm_solution.mrmsolucion } }, as: :json
    assert_response 200
  end

  test "should destroy mrm_solution" do
    assert_difference('MrmSolution.count', -1) do
      delete mrm_solution_url(@mrm_solution), as: :json
    end

    assert_response 204
  end
end
