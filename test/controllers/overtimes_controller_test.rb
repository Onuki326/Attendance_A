require 'test_helper'

class OvertimesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get overtimes_new_url
    assert_response :success
  end

  test "should get create" do
    get overtimes_create_url
    assert_response :success
  end

  test "should get update" do
    get overtimes_update_url
    assert_response :success
  end

end
