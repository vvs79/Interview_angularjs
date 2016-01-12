require 'test_helper'

module Admin
  class TopicsControllerTest < ActionController::TestCase
    def setup
      @topic = create(:topic)
      @question = create(:question)
      @admin = create(:admin)
      sign_in @admin
    end

    test 'should get topic index' do
      get :index
      assert_response :success
      assert_includes @response.body, 'All topics'
      assert_select 'a[href=?]', new_admin_topic_path, text: 'Create new topic'
    end

    test 'should get topic new' do
      get :new
      assert_response :success
      assert_includes @response.body, 'New Topic'
      assert_template partial: "_form"
    end

    test 'should get topic show' do
      assert_no_difference 'Topic.count' do
        assert_routing 'admin/topics/1', controller: "admin/topics", action: "show", id: "1"
        get :show, id: @topic.id
        assert_response :success
        assert_includes @response.body, 'Topic 1'
        assert_select 'a[href=?]', new_admin_question_path, text: 'Add question'
        assert_select 'a[href=?]', edit_admin_topic_path(@topic), text: 'Edit topic'
        if @topic.questions.empty?
          assert_select 'a[href=?]', admin_topic_path(@topic), text: 'Delete topic'
        end
      end
      assert_not_nil flash[:danger] = 'Topic does not exist!'
      assert_template 'admin/topics/show'
    end

    test 'should create topic' do
      assert_no_difference 'Topic.count' do
        post :create, topic: { title: '' }
      end
      assert_not_nil @topic.errors
      assert_template partial: "_form"
      assert_difference 'Topic.count', 1 do
        post :create, topic: { title: 'Some title' }
      end
      assert_not_nil flash[:notice]
      assert_redirected_to admin_topics_path, assigns(:topic)
    end

    test 'should get topic edit' do
      assert_no_difference 'Topic.count' do
        assert_routing 'admin/topics/1', controller: "admin/topics", action: "show", id: "1"
        get :edit, id: @topic.id
        assert_response :success
        assert_includes @response.body, 'Topic 1'
      end
      assert_not_nil flash[:danger] = 'Topic does not exist!'
      assert_template 'admin/topics/edit'
    end

    test 'should update topic' do
      patch :update, id: @topic.id, topic: { title: 'Some title' }
      assert_not_nil flash[:success] = 'Topic updated'
      assert_redirected_to admin_topics_path, assigns(:topic)
    end

    test 'should destroy topic' do
      if @topic.questions.empty?
        assert_difference 'Topic.count', -1 do
          delete :destroy, id: @topic.id
        end
        assert_not_nil flash[:success] = 'Topic deleted'
      end
    end
  end
end
