require 'test_helper'

module Admin
  class QuestionsControllerTest < ActionController::TestCase
    def setup
      @topic = create(:topic)
      @question = create(:question)
      sign_in create(:admin)
      @request.env["HTTP_REFERER"] = "http://test.hostadmin/admin/questions"
    end

    test 'should get question index by admin' do
      get :index
      assert_response :success
      assert_includes @response.body, 'All questions'
    end

    test 'should create question by admin' do
      get :new
      assert_response :success
      assert_includes @response.body, 'Question'
      assert_template partial: "_form"
      assert_difference 'Question.count', 1 do
        post :create, question: { id: @question.id, content: 'Content', answer: 'Answer', topic_id: 1, level: 'beginner' }
      end
      assert_no_difference 'Question.count' do
        post :create, question: { id: @question.id, content: '', answer: @question.answer, topic_id: 1, level: 'good' }
      end
    end

    test "should not create question by interviewer" do
      sign_in create(:interviewer)
      get :new
      assert_response :redirect
    end

    test 'should get question show by admin' do
      assert_routing 'admin/questions/200', controller: "admin/questions", action: "show", id: "200"
      assert_no_difference 'Question.count' do
        get :show, id: @question.id
        assert_response :success
      end
    end

    test 'should not get question show by interviewer' do
      sign_in create(:interviewer)
      assert_no_difference 'Question.count' do
        get :show, id: @question.id
        assert_response :redirect
      end
    end

    test 'should not get question index by interviewer' do
      sign_in create(:interviewer)
      get :index
      assert_response :redirect
    end

    test 'should get question edit by admin' do
      assert_no_difference 'Question.count' do
        get :edit, id: @question.id
        assert_response :success
      end
      assert_template 'admin/questions/edit'
    end

    test 'should not get question edit by interviewer' do
      sign_in create(:interviewer)
      get :edit, id: @question.id
      assert_response :redirect
    end

    test 'should update question by admin' do
      patch :update, id: @question.id, question: { content: 'Another content of the answer' }
      assert_redirected_to admin_question_path, assigns(:question)
    end

    test 'should not get question update by interviewer' do
      sign_in create(:interviewer)
      get :update, id: @question.id
      assert_response :redirect
    end

    test 'should destroy question by admin' do
      assert_difference 'Question.count', -1 do
        delete :destroy, id: @question.id
      end
      assert_redirected_to :back
    end

    test 'should not destroy question by interviewer' do
      sign_in create(:interviewer)
      get :destroy, id: @question.id
      assert_response :redirect
    end
  end
end
