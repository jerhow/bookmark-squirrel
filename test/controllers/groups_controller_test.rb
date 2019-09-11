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
end
