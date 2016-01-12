class UsersController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    redirect_to dashboard_admin_users_path if current_user.admin?
    @total_templates = Template.count
    @total_interviews = Interview.count
  end
end
