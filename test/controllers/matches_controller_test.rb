require 'test_helper'

class MatchesControllerTest < ActionDispatch::IntegrationTest
  test '#create' do
    bob = User.find_by(name: "BobRoss")
    token = JWT.encode({userId: bob.id}, ENV['SECRET'])

    post matches_url, headers:{
      "Access-Token": token
      }

    assert_response :accepted
  end
end
