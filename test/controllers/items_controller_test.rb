require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  test "should get overview" do
    get :overview
    assert_response :success
  end

  test "should get add" do
    get :add
    assert_response :success
  end

  test "should get needed" do
    get :needed
    assert_response :success
  end

  test "should get purchased" do
    get :purchased
    assert_response :success
  end

end
