require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save user without email" do
    user = User.new(name: "Test User", password: "password")
    assert_not user.save, "Saved the user without an email"
  end

  test "should not save user without password" do
    user = User.new(name: "Test User", email: "test@example.com")
    assert_not user.save, "Saved the user without a password"
  end

  test "should not save user with duplicate email" do
    user1 = User.create(name: "User One", email: "test@example.com", password: "password")
    user2 = User.new(name: "User Two", email: "test@example.com", password: "password")
    assert_not user2.save, "Saved the user with a duplicate email"
  end

  test "should save user with valid attributes" do
    user = User.new(name: "Valid User", email: "valid@example.com", password: "password")
    assert user.save, "Failed to save the user with valid attributes"
  end
end
