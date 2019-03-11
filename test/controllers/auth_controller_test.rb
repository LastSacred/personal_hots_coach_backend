require 'test_helper'

class AuthControllerTest < ActionDispatch::IntegrationTest
  test "login" do
    post login_url, params: {
      "user": {
        "name": "BobRoss",
        "password": "happytrees"
      }
    }

    assert_response :ok
  end

  test "bad login" do
    post login_url, params: {
      "user": {
        "name": "SomeGuy",
        "password": "maybeahacker"
      }
    }

    assert_response :unauthorized
  end
end
