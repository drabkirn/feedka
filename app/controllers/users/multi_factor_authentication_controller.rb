class Users::MultiFactorAuthenticationController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  ## POST /users/:id/enable_multi_factor_authentication
  def verify_enable
    if current_user == @user && current_user.authenticate_otp(params[:multi_factor_authentication][:otp_code_token], drift: 60)
      current_user.otp_module_enabled!
      redirect_to edit_user_registration_path, notice: Message.two_fa_enabled
    else
      redirect_to edit_user_registration_path, alert: Message.two_fa_not_enabled
    end
  end

  ## POST /users/:id/disable_multi_factor_authentication
  def verify_disable
    if current_user == @user && current_user.authenticate_otp(params[:multi_factor_authentication][:otp_code_token], drift: 60)
      current_user.otp_module_disabled!
      redirect_to edit_user_registration_path, notice: Message.two_fa_disabled
    else
      redirect_to edit_user_registration_path, alert: Message.two_fa_not_disabled
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end