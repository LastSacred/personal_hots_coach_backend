require 'test_helper'

class StatSetTest < ActiveSupport::TestCase

  test "new" do
    star = users :DavidBowie
    lili = heroes :LiLi
    stub_date = Date.new(2019, 3, 11)

    Date.stub :today, stub_date do
      statset = StatSet.new(star, lili)

      assert_equal "Mephisto", statset.best_against.first[:hero][:name]
      assert_equal 678, statset.best_against.first[:score]
      assert_equal 540, statset.score
      assert_equal 83, statset.win_percent
      assert_equal 6, statset.match_count
    end
  end

end
