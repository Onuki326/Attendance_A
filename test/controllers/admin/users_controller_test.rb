require 'test_helper'

class Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get employee" do
    get admin_users_employee_url
    assert_response :success
  end

end
