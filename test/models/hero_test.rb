require 'test_helper'

class HeroTest < ActiveSupport::TestCase
  test ".import" do
    Hero.import

    assert lili = Hero.find_by(name: "Li Li")
    assert_equal lili.role, "SUPP"
    assert_equal lili.icon_url, "http://s3.hotsapi.net/img/heroes/92x93/lili.png"
  end
end
