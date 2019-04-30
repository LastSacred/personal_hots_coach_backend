require 'test_helper'

class ReplayFilesControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    bob = User.find_by(name: "BobRoss")
    token = JWT.encode({userId: bob.id}, ENV['SECRET'])

    get replay_files_url, headers: {
      "Access-Token": token
    }

    assert_response :ok
    # TODO write test for replay_files#create
  end
end
