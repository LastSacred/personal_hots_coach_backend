require 'test_helper'

class DraftsControllerTest < ActionDispatch::IntegrationTest
  test ".create" do
    bob = User.find_by(name: "BobRoss")
    token = JWT.encode({userId: bob.id}, ENV['SECRET'])
    
    post drafts_url,
      headers:{
        "Access-Token": token
      },
      params: {
        "draft": {
          "map": "Alterac Pass",
          "bans": ["Malthael", "Gul'dan", "Azmodan", "Mephisto"],
          "with_heroes": ["Thrall"],
          "against_heroes":["Li Li", "Diablo", "Muradin"]
      }
}

    assert_response :ok
  end
end
