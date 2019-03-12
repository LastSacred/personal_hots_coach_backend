require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "#roster=" do
    hero_names = [
      "Malthael",
      "Gul'dan",
      "Azmodan"
    ]

    bob = users :BobRoss
    bob.roster = hero_names

    assert_equal hero_names.count, bob.heroes.count
  end

  test "#matches" do
    bob = users :BobRoss

    assert_equal 2, bob.matches.count
  end

  test "#tracked_matches" do
    bob = users :BobRoss
    stub_date = Date.new(2019, 3, 11)

    Date.stub :today, stub_date do
      assert_equal 1, bob.tracked_matches.count
    end
  end

  test "#roster manual" do
    bob = users :BobRoss

    assert_equal 2, bob.roster.count
  end

  test "#roster auto" do
    bob = users :BobRoss
    bob.auto_roster = true

    assert bob.roster.find{ |hero| hero.name == "Li Li" }
  end

  test "#score as_hero" do
    star = users :DavidBowie
    lili = heroes :LiLi

    assert_equal 550, star.score(as_hero: lili)
  end

  test "#score as_hero with_hero" do
    star = users :DavidBowie
    lili = heroes :LiLi
    art = heroes :Artanis

    assert_equal 685, star.score(as_hero: lili, with_hero: art)
  end

  test "#score as_hero against_hero" do
    star = users :DavidBowie
    lili = heroes :LiLi
    meph = heroes :Mephisto

    assert_equal 685, star.score(as_hero: lili, against_hero: meph)
  end

end
