require 'test_helper'

class WishingWellControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get wish" do
    get :wish
    assert_response :success
  end

end
