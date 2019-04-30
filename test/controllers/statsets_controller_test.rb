require 'test_helper'

class StatsetsControllerTest < ActionDispatch::IntegrationTest
  test "show" do
    bob = User.find_by(name: "BobRoss")
    token = JWT.encode({userId: bob.id}, ENV['SECRET'])

    get statsets_url, headers: {
      "Access-Token": token
    }

    assert_response :ok
  end
end
