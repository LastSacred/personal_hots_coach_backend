require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "create" do
    post users_url, params: {
      "user": {
        "name":  "BobRoss",
        "password": "happytrees",
        "battletag": "BobRoss#9999"
      }
    }

    assert_response :created
    assert User.find_by(name: "BobRoss")
  end
end
