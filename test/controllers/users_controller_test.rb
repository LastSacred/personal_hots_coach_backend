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
end
