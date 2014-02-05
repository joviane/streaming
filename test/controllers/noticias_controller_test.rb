require 'test_helper'

class NoticiasControllerTest < ActionController::TestCase
  test "should get stream" do
    get :stream
    assert_response :success
  end

end
