require 'test_helper'

class Admin::BasesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admin_bases_edit_url
    assert_response :success
  end

end
