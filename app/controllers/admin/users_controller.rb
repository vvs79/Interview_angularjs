module Admin
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin
    before_action :load_users, only: [:index, :dashboard]

    def index
      @users = params[:waiting_approval] ? User.waiting_approval : User.all
      @search = @users.search(params[:q] || {})
      @users = @search.result.paginate(page: params[:page] || 1, per_page: 10).order(last_name: :asc)
      add_breadcrumb "users", :admin_users_path
    end

    def dashboard
      @total_questions = Question.count
      @total_topics = Topic.count
    end

    def approve
      User.find(params[:id]).update(approved: true)
      redirect_to admin_users_path, notice: 'User Approved'
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_users_path, notice: 'User not found'
    end

    def destroy
      @user = User.find(params[:id]).destroy
      flash[:success] = 'User deleted'
      redirect_to admin_users_path
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_users_path, notice: 'User not found'
    end

    private

    def check_admin
      return true if current_user.admin?
      redirect_to authenticated_root_path, notice: 'Access Denied'
    end

    def load_users
      @users = User.all
    end
  end
end
