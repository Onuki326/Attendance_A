require 'test_helper'

class RevisesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get revises_new_url
    assert_response :success
  end

  test "should get create" do
    get revises_create_url
    assert_response :success
  end

end
