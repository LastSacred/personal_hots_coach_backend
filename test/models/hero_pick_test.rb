require 'test_helper'

class HeroPickTest < ActiveSupport::TestCase
  test ".match_picks" do
    precount = HeroPick.all.count
    players = @@match["players"]
    mal_player = players.find { |player| player["hero"] == "Malthael" }
    match = matches :empty

    HeroPick.match_picks(match, players)

    mal_pick = HeroPick.find_by(hero: Hero.find_by(name: "Malthael"))

    assert_equal precount + 10 , HeroPick.all.count
    assert mal_pick
    assert_equal mal_player["team"], mal_pick.team
    assert_equal mal_player["winner"], mal_pick.win
    assert_equal mal_player["battletag"], mal_pick.picked_by
    assert_equal match, mal_pick.match
  end
end
