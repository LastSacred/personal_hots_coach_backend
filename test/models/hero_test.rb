require 'test_helper'

class HeroTest < ActiveSupport::TestCase
  test ".import" do
    Hero.import

    assert lili = Hero.find_by(name: "Li Li")
    assert_equal lili.role, "SUPP"
  end
end
