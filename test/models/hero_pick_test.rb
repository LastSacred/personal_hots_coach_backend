require 'test_helper'

class HeroPickTest < ActiveSupport::TestCase
  test ".match_picks" do
    precount = HeroPick.all.count
    players = @@stub_match["players"]
    mal_player = players.find { |player| player["hero"] == "Malthael" }
    match = Match.all.first

    HeroPick.match_picks(match, players)

    mal_pick = HeroPick.find_by(hero: Hero.find_by(name: "Malthael"))

    assert_equal precount + 10 , HeroPick.all.count
    assert mal_pick
  end
end
