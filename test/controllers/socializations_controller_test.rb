require 'test_helper'

class SocializationsControllerTest < ActionController::TestCase
  test "should get like" do
    get :like
    assert_response :success
  end

  test "should get unlike" do
    get :unlike
    assert_response :success
  end

end
