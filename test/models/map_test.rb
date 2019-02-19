require 'test_helper'

class MapTest < ActiveSupport::TestCase
  test ".import" do
    Map.import

    map_names = Map.all.collect { |map| map.name }

    assert_includes(map_names, "Braxis Holdout")
  end
end
