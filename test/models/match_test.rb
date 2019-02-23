require 'test_helper'

class MatchTest < ActiveSupport::TestCase
  test ".upload_replays" do
    precount = Match.count

    Match.upload_replays('./test/replays/')

    assert_equal precount + 2, Match.count
    assert Match.find_by(replay_id: 14319721)
  end
end
