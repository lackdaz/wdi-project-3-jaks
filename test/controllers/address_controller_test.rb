require 'test_helper'

class AddressControllerTest < ActionDispatch::IntegrationTest
  test "should get customer_addresses" do
    get address_customer_addresses_url
    assert_response :success
  end

end
