require 'test_helper'

class InterviewsControllerTest < ActionController::TestCase
  def setup
    @interview = create(:interview)
    sign_in create(:interviewer)
  end

  test 'should get interview index for approved interviewer' do
    get :index
    assert_response :success
    assert_includes @response.body, 'All interviews'
    assert_select 'a[href=?]', new_interview_path, text: 'New interview'
  end

  test 'should get interview index for admin' do
    sign_in create(:admin)
    get :index
    assert_response :redirect
  end

  test 'should get interview index for not approved interviewer' do
    sign_in create(:not_approved_interviewer)
    get :index
    assert_redirected_to user_session_path
  end

  test 'should get new for approved interviewer' do
    get :new
    assert_response :success
  end

  test 'should get new for admin' do
    sign_in create(:admin)
    get :new
    assert_response :redirect
  end

  test 'should get new for not approved interviewer' do
    sign_in create(:not_approved_interviewer)
    get :new
    assert_redirected_to user_session_path
  end

  test 'should create interview by interviewer' do
    get :new
    assert_response :success
    assert_includes @response.body, 'Interview'
    assert_difference 'Interview.count', 1 do
      post :create, interview: { id: @interview.id, firstname: 'John', lastname: 'Johnson', target_level: 'beginner', template_id: 3, user_id: 2 }
    end
    assert_no_difference 'Interview.count' do
      post :create, interview: { id: @interview.id, firstname: '', lastname: '' }
    end
  end

  test 'not should create interview by admin' do
    sign_in create(:admin)
    assert_no_difference 'Interview.count' do
      post :create, interview: { id: @interview.id, firstname: 'John', lastname: 'Johnson', target_level: 'beginner', template_id: 3, user_id: 2 }
    end
    assert_response :redirect
  end

  test 'not should create interview by not_approved_interviewer' do
    sign_in create(:not_approved_interviewer)
    assert_no_difference 'Interview.count' do
      post :create, interview: { id: @interview.id, firstname: 'John', lastname: 'Johnson', target_level: 'beginner', template_id: 3, user_id: 2 }
    end
    assert_redirected_to user_session_path
  end

  test 'should destroy interview by interviewer' do
    assert_difference 'Interview.count', -1 do
      delete :destroy, id: @interview.id
    end
    assert_redirected_to interviews_path
  end

  test 'not should destroy interview by admin' do
    sign_in create(:admin)
    assert_no_difference 'Interview.count' do
      delete :destroy, id: @interview.id
    end
    assert_response :redirect
  end

  test 'not should destroy interview by not_approved_interviewer' do
    sign_in create(:not_approved_interviewer)
    assert_no_difference 'Interview.count' do
      delete :destroy, id: @interview.id
    end
    assert_redirected_to user_session_path
  end
end
