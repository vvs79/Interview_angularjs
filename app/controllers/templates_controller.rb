include ActionView::Helpers::TextHelper

class TemplatesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  add_breadcrumb "templates", :templates_path

  def index
    @templates = Template.order(created_at: :desc).paginate(page: params[:page], :per_page => 10)
  end

  def new
    @template = Template.new
    add_breadcrumb 'new_template', new_template_path
  end

  def show
    @template = Template.find(params[:id])
    add_breadcrumb @template.name, template_path(@template)
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = 'Template does not exist!'
    redirect_to templates_path
  end

  def create
    @template = Template.new(template_params)
    @questions = Question.where(:id => params[:template][:question_ids])
    @template.questions = @questions
    if @template.save
      flash[:success] = 'Template was successfully created'
      redirect_to template_path(@template)
    else
      render 'new'
    end
  end

  def edit
    @template = Template.find(params[:id])
    add_breadcrumb @template.name, edit_template_path(@template)
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = 'Template does not exist!'
    redirect_to templates_path
  end

  def update
    @template = Template.find(params[:id])
    @questions = Question.where(:id => params[:template][:question_ids])
    @template.questions = @questions
    if @template.update_attributes(name: template_params[:name])
      flash[:success] = 'Template updated'
      redirect_to template_path(@template)
    else
      render 'edit'
    end
  end

  def destroy
    Template.find(params[:id]).destroy
    flash[:success] = 'Template deleted'
    redirect_to templates_path
  end

  private

  def template_params
    params.require(:template).permit(:name, :question_ids => [])
  end

  def check_admin
    return true unless current_user.admin?
    redirect_to authenticated_root_path, notice: 'Access Denied'
  end
end
