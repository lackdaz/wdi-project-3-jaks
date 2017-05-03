require 'test_helper'

class StallControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get stall_new_url
    assert_response :success
  end

  test "should get show" do
    get stall_show_url
    assert_response :success
  end

  test "should get index" do
    get stall_index_url
    assert_response :success
  end

  test "should get edit" do
    get stall_edit_url
    assert_response :success
  end

end
