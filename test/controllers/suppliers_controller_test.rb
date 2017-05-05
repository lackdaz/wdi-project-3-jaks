require 'test_helper'

class SuppliersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get suppliers_index_url
    assert_response :success
  end

<<<<<<< HEAD
  test "should get new" do
    get suppliers_new_url
    assert_response :success
  end

=======
>>>>>>> 51e94aba8985e05d62792842199d79d7496af899
end
