require 'test_helper'

class TestControllerTest < ActionDispatch::IntegrationTest
  test "should get testnew" do
    get test_testnew_url
    assert_response :success
  end

end
