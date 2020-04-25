class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected
    def configure_permitted_parameters
      sign_up_added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
      update_added_attrs = [:email, :password, :password_confirmation, :remember_me]
      devise_parameter_sanitizer.permit :sign_up, keys: sign_up_added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: update_added_attrs
    end
end
