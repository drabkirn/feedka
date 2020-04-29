class Users::SessionsController < Devise::SessionsController

  ## POST /users/sign_in
  ## This also checks for 2FA code if user has enabled 2FA
  def create
    self.resource = warden.authenticate!(auth_options)

    if resource && resource.otp_module_disabled?
      continue_sign_in(resource, resource_name)
    elsif resource && resource.otp_module_enabled?
      supplied_otp_code = params[:user][:otp_code_token]
      if supplied_otp_code && supplied_otp_code.size > 0
        if resource.authenticate_otp(supplied_otp_code, drift: 60)
          continue_sign_in(resource, resource_name)
        else
          sign_out resource
          redirect_to root_url, alert: Message.two_fa_wrong
        end
      else
        sign_out resource
        redirect_to root_url, alert: Message.two_fa_empty
      end
    end
  end

  private
    def continue_sign_in(resource, resource_name)
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end
end