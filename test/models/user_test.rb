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

  test "#my_matches" do
    bob = users :BobRoss

    assert_equal 2, bob.my_matches.count
  end

  test "#tracked_matches none" do
    mrnofun = users :MrNoFun
    stub_date = Date.new(2019, 3, 11)

    Date.stub :today, stub_date do
      assert_equal 0, mrnofun.tracked_matches.count
    end
  end

  test "#tracked_matches quick_match" do
    mrnofun = users :MrNoFun
    mrnofun.update(track_quick_match: true)
    stub_date = Date.new(2019, 3, 11)

    Date.stub :today, stub_date do
      assert_equal 1, mrnofun.tracked_matches.count
    end
  end

  test "#tracked_matches unranked_draft" do
    mrnofun = users :MrNoFun
    mrnofun.update(track_unranked_draft: true)
    stub_date = Date.new(2019, 3, 11)

    Date.stub :today, stub_date do
      assert_equal 1, mrnofun.tracked_matches.count
    end
  end

  test "#tracked_matches ranked_draft" do
    mrnofun = users :MrNoFun
    mrnofun.update(track_ranked_draft: true)
    stub_date = Date.new(2019, 3, 11)

    Date.stub :today, stub_date do
      assert_equal 3, mrnofun.tracked_matches.count
    end
  end

  test "#roster manual" do
    bob = users :BobRoss

    assert_equal 2, bob.roster.count
  end

  test "#roster auto" do
    bob = users :BobRoss
    bob.auto_roster = true
    stub_date = Date.new(2019, 3, 11)

    Date.stub :today, stub_date do
      assert bob.roster.find{ |hero| hero.name == "Li Li" }
      assert_equal 1, bob.roster.count
    end
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

    stub_date = Date.new(2019, 3, 11)

    Date.stub :today, stub_date do
      pick_list = star.pick_list(draft)

      assert_equal 1, pick_list.count
      assert_equal lili, pick_list.first[:hero]
      assert_equal 672, pick_list.first[:score]
    end
  end

  test '#import' do
    bob = users :BobRoss
    bob.import
    match = Match.find_by(replay_id: 14319721)

    assert match.complete
  end

  test '#fix_battletags' do
    phil = users :DrPhil
    phil.fix_battletags

    brokenpick = hero_picks :brokenpick
    assert_equal 'DrPhil#0003', brokenpick.picked_by
  end
end
