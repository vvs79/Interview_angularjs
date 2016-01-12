module Admin
  class TopicsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin
    add_breadcrumb "topics", :admin_topics_path
    def index
      @topics = Topic.paginate(page: params[:page], per_page: 8)
    end

    def new
      @topic = Topic.new
      add_breadcrumb "new topic", new_admin_topic_path
    end

    def show
      @topic = Topic.find(params[:id])
      add_breadcrumb @topic.title, admin_topic_path(@topic)
      @questions = @topic.questions.order(created_at: :desc).paginate(page: params[:page], :per_page => 10)
    rescue ActiveRecord::RecordNotFound
      flash[:danger] = 'Topic does not exist!'
      redirect_to admin_topics_path
    end

    def create
      @topic = Topic.new(topic_params)
      respond_to do |format|
        if @topic.save
          format.html { redirect_to admin_topics_path, notice: 'Topic was successfully created' }
          format.json { render :show, status: :created, location: @topic }
        else
          format.html { render :new }
          format.json { render json: @topic.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit
      @topic = Topic.find(params[:id])
      add_breadcrumb @topic.title, edit_admin_topic_path(@topic)
    rescue ActiveRecord::RecordNotFound
      flash[:danger] = 'Topic does not exist!'
      redirect_to admin_topics_path
    end

    def update
      @topic = Topic.find(params[:id])
      if @topic.update_attributes(topic_params)
        flash[:success] = 'Topic updated'
        redirect_to admin_topics_path
      else
        render 'edit'
      end
    end

    def destroy
      @topic = Topic.find(params[:id])
      if @topic.questions.empty?
        @topic.destroy
        flash[:success] = 'Topic deleted'
        redirect_to admin_topics_path
      else
        flash[:danger] = 'You can not delete topic with questions!'
        redirect_to admin_topics_path
      end
    end

    private

    def topic_params
      params.require(:topic).permit(:title, :image)
    end

    def check_admin
      return true if current_user.admin?
      redirect_to authenticated_root_path, notice: 'Access Denied'
    end
  end
end
