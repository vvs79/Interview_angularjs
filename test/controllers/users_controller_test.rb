require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should redirect to dashboard for admin" do
    sign_in create(:admin)
    get :dashboard
    assert_response :redirect
  end

  test "should get dashboard for interviewer" do
    sign_in create(:interviewer)
    get :dashboard
    assert_response :success
  end

  test "should redirect dashboard for not approved interviewer" do
    sign_in create(:not_approved_interviewer)
    get :dashboard
    assert_redirected_to user_session_path
  end

  test "should redirect dashboard for not logged in users" do
    get :dashboard
    assert_redirected_to user_session_path
  end
end
