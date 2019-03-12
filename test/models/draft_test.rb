require 'test_helper'

class DraftTest < ActiveSupport::TestCase
  test ".initialize" do
    alt = maps :alterac
    draft = Draft.new(@@draft_props)
    draft.user = users :BobRoss

    assert draft.user
    assert_equal alt, draft.map
    assert_equal 4, draft.bans.count
    assert_equal 2, draft.with_heroes.count
    assert_equal 3, draft.against_heroes.count
  end
end
