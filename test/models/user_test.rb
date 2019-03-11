require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test ".roster=" do
    hero_names = [
      "Malthael",
      "Gul'dan",
      "Azmodan"
    ]

    bob = User.find_by(name: "BobRoss")
    bob.roster = hero_names

    assert_equal hero_names.count, bob.heroes.count
  end

  test ".matches" do
    bob = User.find_by(name: "BobRoss")

    assert_equal 1, bob.matches.count
  end
end
