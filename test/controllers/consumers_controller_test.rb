require 'test_helper'

class ConsumersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get consumers_new_url
    assert_response :success
  end

  test "should get edit" do
    get consumers_edit_url
    assert_response :success
  end

  test "should get create" do
    get consumers_create_url
    assert_response :success
  end

  test "should get delete" do
    get consumers_delete_url
    assert_response :success
  end

  test "should get show" do
    get consumers_show_url
    assert_response :success
  end

  test "should get update" do
    get consumers_update_url
    assert_response :success
  end

end
