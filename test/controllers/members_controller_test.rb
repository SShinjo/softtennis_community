require 'test_helper'

class MembersControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get members_edit_url
    assert_response :success
  end

end
