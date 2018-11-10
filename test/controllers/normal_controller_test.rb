require 'test_helper'

class NormalControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get normal_update_url
    assert_response :success
  end

end
