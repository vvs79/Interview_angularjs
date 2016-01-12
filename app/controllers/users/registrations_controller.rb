module Users
  class RegistrationsController < Devise::RegistrationsController
    before_filter :configure_permitted_parameters
    add_breadcrumb 'update_profile', :edit_user_registration_path

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up).push(:first_name, :last_name)
      devise_parameter_sanitizer.for(:account_update).push(:first_name, :last_name)
    end
  end
end
