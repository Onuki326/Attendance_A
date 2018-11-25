require 'test_helper'

class AploysControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get aploys_create_url
    assert_response :success
  end

end
