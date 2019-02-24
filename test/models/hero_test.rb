require 'test_helper'

class HeroTest < ActiveSupport::TestCase
  test ".import" do
    Hero.import

    assert aba = Hero.find_by(name: "Abathur")
    assert_equal aba.role, "SPEC"
    assert_equal aba.icon_url, "http://s3.hotsapi.net/img/heroes/92x93/abathur.png"
  end
end
