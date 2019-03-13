require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "diablo" do
  #   star = users :DavidBowie
  #   lili = heroes :LiLi
  #   diab = heroes :Diablo
  #
  #   assert_equal 0, star.score(as_hero: lili, against_hero: diab)
  # end

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
    assert_equal 1, bob.roster.count
  end

  test "#score as_hero" do
    star = users :DavidBowie
    lili = heroes :LiLi

    assert_equal 540, star.score(as_hero: lili)
  end

  test "#score as_hero with_hero" do
    star = users :DavidBowie
    lili = heroes :LiLi
    art = heroes :Artanis

    assert_equal 678, star.score(as_hero: lili, with_hero: art)
  end

  test "#score as_hero on_map" do
    star = users :DavidBowie
    lili = heroes :LiLi
    alterac = maps :alterac

    assert_equal 770, star.score(as_hero: lili, map: alterac)
  end

  test "#score as_hero on_map with_hero" do
    star = users :DavidBowie
    lili = heroes :LiLi
    art = heroes :Artanis
    alterac = maps :alterac

    assert_equal 871, star.score(as_hero: lili, with_hero: art, map: alterac)
  end

  test "#score as_hero on_map against_hero" do
    star = users :DavidBowie
    lili = heroes :LiLi
    meph = heroes :Mephisto
    alterac = maps :alterac

    assert_equal 871, star.score(as_hero: lili, against_hero: meph, map: alterac)
  end

  test "#score draft start" do
    star = users :DavidBowie
    lili = heroes :LiLi
    alterac = maps :alterac

    draft = {
      map: alterac,
      with_heroes: [],
      against_heroes: []
    }

    assert_equal 770, star.score(as_hero: lili, draft: draft)
  end

  test "#score draft later" do
    star = users :DavidBowie
    lili = heroes :LiLi
    alterac = maps :alterac
    thrall = heroes :Thrall
    malf = heroes :Malfurion
    art = heroes :Artanis
    meph = heroes :Mephisto
    diab = heroes :Diablo

    draft = {
      map: alterac,
      with_heroes: [art, malf],
      against_heroes: [diab, meph, thrall]
    }

    assert_equal 709, star.score(as_hero: lili, draft: draft)
  end

  test "#pick_list" do
    star = users :DavidBowie
    lili = heroes :LiLi
    alterac = maps :alterac
    thrall = heroes :Thrall
    malf = heroes :Malfurion
    art = heroes :Artanis
    meph = heroes :Mephisto
    diab = heroes :Diablo

    draft = {
      map: alterac,
      with_heroes: [art, malf],
      against_heroes: [diab, meph, thrall]
    }

    pick_list = star.pick_list(draft)
    
    assert_equal 1, pick_list.count
    assert_equal lili, pick_list.first[:hero]
    assert_equal 709, pick_list.first[:score]
  end

end
