require 'test_helper'

class TemplatesControllerTest < ActionController::TestCase
  def setup
    @template = create(:template)
    @question1 = create(:question)
    sign_in create(:interviewer)
  end

  test 'should get template index for approved interviewer' do
    get :index
    assert_response :success
    assert_includes @response.body, 'All templates'
  end

  test 'should get template index for admin' do
    sign_in create(:admin)
    get :index
    assert_response :redirect
  end

  test 'should get template index for not approved interviewer' do
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

  test "should redirect edit for approved interviewer" do
    get :edit, id: @template
    assert_response :success
  end

  test "should redirect edit for admin" do
    sign_in create(:admin)
    get :edit, id: @template
    assert_response :redirect
  end

  test "should redirect edit for not approved interviewer" do
    sign_in create(:not_approved_interviewer)
    get :edit, id: @template
    assert_redirected_to user_session_path
  end

  test 'should get template update by interviewer' do
    patch :update, id: @template.id, template: { name: 'Another name',
                                                 question_ids: [@question1.id] }
    assert_redirected_to template_path, assigns(:template)
    @template.reload
    assert_equal @template.name, 'Another name'
    assert_equal @template.question_ids.count, 1
  end

  test 'should get not template update by admin' do
    sign_in create(:admin)
    get :update, id: @template
    assert_response :redirect
  end

  test 'should get not template update by not_approved_interviewer' do
    sign_in create(:not_approved_interviewer)
    get :update, id: @template
    assert_response :redirect
  end

  test 'should create template by interviewer' do
    get :new
    assert_response :success
    assert_includes @response.body, 'New template'
    assert_template partial: "_form"
    assert_difference 'Template.count', 1 do
      post :create, template: { name: 'Template`s name',
                                question_ids: [@question1.id] }
    end
    assert_no_difference 'Template.count' do
      post :create, template: { name: '' }
    end
  end

  test 'not should create template by admin' do
    sign_in create(:admin)
    assert_no_difference 'Template.count' do
      post :create, template: { name: 'Template`s name',
                                question_id: [@question1.id] }
    end
    assert_response :redirect
  end

  test 'not should create template by not_approved_interviewer' do
    sign_in create(:not_approved_interviewer)
    assert_no_difference 'Template.count' do
      post :create, template: { name: 'Template`s name',
                                question_ids: [@question1.id] }
    end
    assert_redirected_to user_session_path
  end

  test 'should destroy template by interviewer' do
    assert_difference 'Template.count', -1 do
      delete :destroy, id: @template.id
    end
    assert_redirected_to templates_path
  end

  test 'not should destroy template by admin' do
    sign_in create(:admin)
    assert_no_difference 'Template.count' do
      delete :destroy, id: @template.id
    end
    assert_response :redirect
  end

  test 'not should destroy template by not_approved_interviewer' do
    sign_in create(:not_approved_interviewer)
    assert_no_difference 'Template.count' do
      delete :destroy, id: @template.id
    end
    assert_redirected_to user_session_path
  end
end
