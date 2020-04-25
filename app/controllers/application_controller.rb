class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected
    ## Devise whitelist params for users signup and updates
    def configure_permitted_parameters
      sign_up_added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
      update_added_attrs = [:email, :password, :password_confirmation, :remember_me]
      devise_parameter_sanitizer.permit :sign_up, keys: sign_up_added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: update_added_attrs
    end

    ## Devise - after sign_in, goto /feeds
    def after_sign_in_path_for(resource)
      feeds_path
    end

    ## Devise - after sign out, goto /
    def after_sign_out_path_for(resource)
      root_path
    end
end
