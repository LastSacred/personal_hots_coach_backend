require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test ".roster" do
    hero_names = [
      "Malthael",
      "Gul'dan",
      "Azmodan"
    ]

    bob = User.find_by(name: "BobRoss")
    bob.roster = hero_names

    assert_equal 3, bob.heroes.count
  end
end
