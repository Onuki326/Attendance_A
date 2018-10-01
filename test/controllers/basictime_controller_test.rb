require 'test_helper'

class BasictimeControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get basictime_edit_url
    assert_response :success
  end

  test "should get create" do
    get basictime_create_url
    assert_response :success
  end

  test "should get update" do
    get basictime_update_url
    assert_response :success
  end

end
