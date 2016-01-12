require 'test_helper'

module Admin
  class UsersControllerTest < ActionController::TestCase
    test "should redirect index when not logged in" do
      get :index
      assert_redirected_to new_user_session_path
    end

    test "should get index" do
      sign_in create(:admin)
      get :index
      assert_response :success
    end

    test "should redirect index if not admin (interviewer)" do
      sign_in create(:interviewer)
      get :index
      assert_redirected_to authenticated_root_path
    end
  end
end
