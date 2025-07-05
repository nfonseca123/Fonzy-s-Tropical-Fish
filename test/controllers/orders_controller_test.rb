require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get checkout" do
    get orders_checkout_url
    assert_response :success
  end

  test "should get process_checkout" do
    get orders_process_checkout_url
    assert_response :success
  end

  test "should get show" do
    get orders_show_url
    assert_response :success
  end
end
