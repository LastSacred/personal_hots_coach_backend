require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "create" do
    post users_url, params: {
      "user": {
        "name":  "BobRoss2",
        "password": "happytrees",
        "battletag": "BobRoss#9992"
      }
    }

    assert_response :created
    assert User.find_by(name: "BobRoss")
  end

  test "update" do
    bob = User.find_by(name: "BobRoss")
    token = JWT.encode({userId: bob.id}, ENV['SECRET'])

    patch users_url, headers:{
      "Access-Token": token
      },
      params: {
        "user": {
          "replay_path": "/newpath",
          "roster": ["Li Li", "Artanis"]
      }
    }

    assert_response :ok
  end
end
