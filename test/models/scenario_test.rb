require 'test_helper'
# TODO: add VCR
class ScenarioTest < ActiveSupport::TestCase

  test "as_hero" do
    star = users :DavidBowie
    lili = heroes :LiLi
    stub_date = Date.new(2019, 3, 11)

    Date.stub :today, stub_date do
      scenario = Scenario.new(user: star, as_hero: lili)

      # assert_equal 540, scenario.score
      assert_equal 83, scenario.win_percent
      assert_equal 6, scenario.match_count
    end
  end

  test "as_hero with_hero" do
    star = users :DavidBowie
    lili = heroes :LiLi
    art = heroes :Artanis
    stub_date = Date.new(2019, 3, 11)

    Date.stub :today, stub_date do
      scenario = Scenario.new(user: star, as_hero: lili, with_hero: art)

      assert_equal 678, scenario.score
      assert_equal 100, scenario.win_percent
      assert_equal 3, scenario.match_count
    end
  end

  test "as_hero on_map" do
    star = users :DavidBowie
    lili = heroes :LiLi
    alterac = maps :alterac
    stub_date = Date.new(2019, 3, 11)

    Date.stub :today, stub_date do
      scenario = Scenario.new(user: star, as_hero: lili, map: alterac)

      assert_equal 770, scenario.score
      assert_equal 100, scenario.win_percent
      assert_equal 5, scenario.match_count
    end
  end

  test "#score as_hero on_map with_hero" do
    star = users :DavidBowie
    lili = heroes :LiLi
    art = heroes :Artanis
    alterac = maps :alterac
    stub_date = Date.new(2019, 3, 11)

    Date.stub :today, stub_date do
      scenario = Scenario.new(user: star, as_hero: lili, with_hero: art, map: alterac)

      assert_equal 871, scenario.score
      assert_equal 100, scenario.win_percent
      assert_equal 3, scenario.match_count
    end
  end

  test "#score as_hero on_map against_hero" do
    star = users :DavidBowie
    lili = heroes :LiLi
    meph = heroes :Mephisto
    alterac = maps :alterac
    stub_date = Date.new(2019, 3, 11)

    Date.stub :today, stub_date do
      scenario = Scenario.new(user: star, as_hero: lili, against_hero: meph, map: alterac)

      assert_equal 871, scenario.score
      assert_equal 100, scenario.win_percent
      assert_equal 3, scenario.match_count
    end
  end

  test "draft start" do
    star = users :DavidBowie
    lili = heroes :LiLi
    alterac = maps :alterac

    draft = {
      map: alterac,
      with_heroes: [],
      against_heroes: []
    }

    stub_date = Date.new(2019, 3, 11)

    Date.stub :today, stub_date do
      scenario = Scenario.new(user: star, as_hero: lili, draft: draft)

      assert_equal 770, scenario.score
      assert_equal 0, scenario.match_count
    end
  end

  test "draft later" do
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
      scenario = Scenario.new(user: star, as_hero: lili, draft: draft)

      assert_equal 672, scenario.score
      assert_equal 0, scenario.match_count
    end
  end

end
