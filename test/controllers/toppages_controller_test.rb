require 'test_helper'

class ToppagesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get toppages_top_url
    assert_response :success
  end

end
