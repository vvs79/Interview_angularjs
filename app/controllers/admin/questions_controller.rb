include ActionView::Helpers::TextHelper

module Admin
  class QuestionsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin
    add_breadcrumb "questions", :admin_questions_path
    def index
      @questions = Question.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    end

    def show
      @question = Question.find(params[:id])
      @topic = @question.topic
      add_breadcrumb truncate(@question.content, length: 25), admin_question_path(@question)
    rescue ActiveRecord::RecordNotFound
      flash[:danger] = 'Question does not exist!'
      redirect_to admin_questions_path
    end

    def new
      @question = Question.new
      add_breadcrumb "new question", new_admin_question_path
    end

    def create
      @question = Question.new(question_params)
      if @question.save
        flash[:success] = 'Question was successfully created'
        redirect_to admin_question_path(@question)
      else
        render 'new'
      end
    end

    def edit
      @question = Question.find(params[:id])
      add_breadcrumb truncate(@question.content, length: 25), edit_admin_question_path(@question)
    rescue ActiveRecord::RecordNotFound
      flash[:danger] = 'Question does not exist!'
      redirect_to admin_questions_path
    end

    def update
      @question = Question.find(params[:id])
      if @question.update_attributes(question_params)
        flash[:success] = 'Question updated'
        redirect_to admin_question_path
      else
        render 'edit'
      end
    end

    def destroy
      Question.find(params[:id]).destroy
      flash[:success] = 'Question deleted'
      redirect_to :back
    end

    private

    def question_params
      params.require(:question).permit(:topic_id, :content, :answer, :level)
    end

    def check_admin
      return true if current_user.admin?
      redirect_to authenticated_root_path, notice: 'Access Denied'
    end
  end
end
