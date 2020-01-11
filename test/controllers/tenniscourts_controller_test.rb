require 'test_helper'

class TenniscourtsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tenniscourts_index_url
    assert_response :success
  end

  test "should get show" do
    get tenniscourts_show_url
    assert_response :success
  end

end
