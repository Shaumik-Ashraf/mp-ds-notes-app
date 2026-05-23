require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "user with email and password is valid" do
    user = User.new(email: "carol@example.com", password: "password123")
    assert user.valid?
  end

  test "user without email is invalid" do
    user = User.new(password: "password123")
    assert_not user.valid?
  end

  test "user with short password is invalid" do
    user = User.new(email: "bob@example.com", password: "abc12")
    assert_not user.valid?
  end

  test "user authenticates with correct password" do
    user = users(:alice)
    assert user.valid_password?("password123")
  end

  test "user does not authenticate with wrong password" do
    user = users(:alice)
    assert_not user.valid_password?("wrongpassword")
  end
end
