require 'test_helper'

class HeroesControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get heroes_url

    assert_response :ok
  end
end
