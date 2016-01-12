class InterviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_interviewer
  respond_to :json, :html
  add_breadcrumb "interviews", :interviews_path
  def index
    respond_with Interview.order(created_at: :desc)
    #@interviews = Interview.order(created_at: :desc).paginate(page: params[:page], :per_page => 10)
  end

  def new
    add_breadcrumb "new_interview", new_interview_path
    respond_with Interview.new
    #@interview = Interview.new
    #add_breadcrumb "new_interview", new_interview_path
  end

  def show
    @interview = Interview.find(params[:id])
    @questions = @interview.questions
    add_breadcrumb @interview.id, interview_path(@interview)
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = 'Interview does not exist!'
    redirect_to interviews_path
  end

  def create
    respond_with Interview.create interview_params
    # @interview = Interview.new(interview_params)
    # @questions = @interview.questions
    #if @interview.save
      #redirect_to interview_path(@interview), notice: 'Interview was successfully created'
    #else
    #  render :new
    #end
  end

  def destroy
    respond_with Interview.destroy params[:id]
    # Interview.find(params[:id]).destroy
    flash[:success] = 'Interview deleted'
    redirect_to interviews_path
  end

  private

  def interview_params
    params.require(:interview).permit(:firstname, :lastname, :target_level, :template_id, :user_id)
  end

  def check_interviewer
    return true unless current_user.admin?
    redirect_to authenticated_root_path, notice: 'Access Denied'
  end
end
