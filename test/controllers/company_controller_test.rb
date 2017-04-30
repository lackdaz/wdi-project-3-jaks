require 'test_helper'

class CompanyControllerTest < ActionDispatch::IntegrationTest
  test "should get company_profile" do
    get company_company_profile_url
    assert_response :success
  end

end
