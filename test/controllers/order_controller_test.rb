require 'test_helper'

class OrderControllerTest < ActionDispatch::IntegrationTest
  test "should get all_orders" do
    get order_all_orders_url
    assert_response :success
  end

end
