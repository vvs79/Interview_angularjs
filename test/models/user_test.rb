require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = create(:interviewer)
    @not_approved_interviewer = create(:not_approved_interviewer)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "first_name should be present" do
    @user.last_name = "     "
    assert_not @user.valid?
  end

  test "last_name should be present" do
    @user.last_name = "     "
    assert_not @user.valid?
  end

  test "first_name should not be too long" do
    @user.first_name = "a" * 51
    assert_not @user.valid?
  end

  test "last_name should not be too long" do
    @user.last_name = "a" * 51
    assert_not @user.valid?
  end

  test "should return false for not approved interviewers" do
    assert_not @not_approved_interviewer.approved?
  end
end
