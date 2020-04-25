class Users::MultiFactorAuthenticationController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def verify_enable
    if current_user == @user && current_user.authenticate_otp(params[:multi_factor_authentication][:otp_code_token], drift: 60)
      current_user.otp_module_enabled!
      redirect_to edit_user_registration_path, notice: 'Two Factor Authentication Enabled'
    else
      redirect_to edit_user_registration_path, alert: 'Two Factor Authentication could not be enabled'
    end
  end

  def verify_disabled
    if current_user == @user && current_user.authenticate_otp(params[:multi_factor_authentication][:otp_code_token], drift: 60)
      current_user.otp_module_disabled!
      redirect_to edit_user_registration_path, notice: 'Two Factor Authentication Disabled'
    else
      redirect_to edit_user_registration_path, alert: 'Two Factor Authentication could not be disabled'
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end