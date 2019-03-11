require 'test_helper'

class MapsControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get maps_url

    assert_response :ok
  end
end
