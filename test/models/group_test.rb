require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  test "valid group" do
    group = groups(:valid)
    assert group.valid?
  end

  test "invalid group missing title" do
    group = groups(:missing_title)
    assert_not group.valid?
  end

  test "create a group and save it" do
    group = groups(:valid)
    assert group.save
  end
end
