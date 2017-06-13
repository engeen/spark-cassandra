require 'test_helper'

class CityControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get city_index_url
    assert_response :success
  end

  test "should get show" do
    get city_show_url
    assert_response :success
  end

  test "should get edit" do
    get city_edit_url
    assert_response :success
  end

  test "should get update" do
    get city_update_url
    assert_response :success
  end

end
