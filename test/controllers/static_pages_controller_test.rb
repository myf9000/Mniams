require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get News" do
    get :News
    assert_response :success
  end

  test "should get About" do
    get :About
    assert_response :success
  end

  test "should get Contact" do
    get :Contact
    assert_response :success
  end

end
