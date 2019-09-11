require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  include GroupAccessConcern

  test "group exists" do
    group = groups(:valid)
    assert group_exists?(group)
  end

  test "user can access group" do
    group = Group.new(title: "", owner_user_id: 1)
    user = User.new(id: 1, name: "", email: "")
    group.users << user
    assert user_can_access_group?(group, user)
  end

  test "user owns group" do
    group = Group.new(title: "", owner_user_id: 1)
    user = User.new(id: 1, name: "", email: "")
    group.users << user
    assert is_group_owner?(group, user)
  end

  test "user does not own group" do
    group = Group.new(title: "", owner_user_id: 1)
    user = User.new(id: 2, name: "", email: "")
    group.users << user
    assert_not is_group_owner?(group, user)
  end
end
