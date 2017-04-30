require 'test_helper'

class ConsumerControllerTest < ActionDispatch::IntegrationTest
  test "should get consumer_profile" do
    get consumer_consumer_profile_url
    assert_response :success
  end

end
