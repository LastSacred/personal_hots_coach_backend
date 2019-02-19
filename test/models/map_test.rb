require 'test_helper'

class MapTest < ActiveSupport::TestCase
  test ".import" do
    Map.import

    assert Map.find_by(name: "Braxis Holdout")
  end
end
