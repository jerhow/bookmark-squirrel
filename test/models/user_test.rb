require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "valid user" do
    user = users(:valid)
    assert user.valid?
  end

  test "invalid user missing name" do
    user = users(:missing_name)
    assert_not user.valid?
  end

  test "invalid user missing email" do
    user = users(:missing_email)
    assert_not user.valid?
  end

  test "create a user and save it" do
    user = users(:valid)
    assert user.save!
  end
end
