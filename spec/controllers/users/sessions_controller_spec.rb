require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  describe "POST #create" do
    context "when user successfully signs in" do
      context "with 2FA not enabled" do
        before(:each) do
          @request.env["devise.mapping"] = Devise.mappings[:user]
          @user = create(:confirmed_user)
          post :create, params: { user: { email: @user.email, password: "12345678" } }
        end
  
        it "redirects to feeds_path" do
          expect(response).to redirect_to feeds_path
        end
  
        it "shows successfully signed in message" do
          expect(flash[:notice]).to eq "Signed in successfully."
        end
      end

      context "with 2FA enabled" do
        before(:each) do
          @request.env["devise.mapping"] = Devise.mappings[:user]
          @user = create(:confirmed_user)
          @user.otp_module = "enabled"
          @user.save
          post :create, params: { user: { email: @user.email, password: "12345678", otp_code_token: @user.otp_code } }
        end
  
        it "redirects to feeds_path" do
          expect(response).to redirect_to feeds_path
        end
  
        it "shows successfully signed in message" do
          expect(flash[:notice]).to eq "Signed in successfully."
        end
      end
    end

    context "when user is not signed in successfully" do
      context "when email is wrong" do
        before(:each) do
          @request.env["devise.mapping"] = Devise.mappings[:user]
          @user = create(:confirmed_user)
          post :create, params: { user: { email: 'a@b.com', password: "12345678" } }
        end
  
        it "renders the new template with errors" do
          expect(response).to render_template(:new)
        end
  
        it "shows invalid credentials in message" do
          expect(flash[:alert]).to eq "Invalid Email or password."
        end
      end

      context "when password is wrong" do
        before(:each) do
          @request.env["devise.mapping"] = Devise.mappings[:user]
          @user = create(:confirmed_user)
          post :create, params: { user: { email: @user.email, password: "12345678910" } }
        end
  
        it "renders the new template with errors" do
          expect(response).to render_template(:new)
        end
  
        it "shows invalid credentials message" do
          expect(flash[:alert]).to eq "Invalid Email or password."
        end
      end

      context "when OTP Module is enabled with no token" do
        before(:each) do
          @request.env["devise.mapping"] = Devise.mappings[:user]
          @user = create(:confirmed_user)
          @user.otp_module = "enabled"
          @user.save
          post :create, params: { user: { email: @user.email, password: "12345678", otp_code_token: "" } }
        end
  
        it "redirects to root_path" do
          expect(response).to redirect_to root_path
        end
  
        it "shows invalid 2FA code message" do
          expect(flash[:alert]).to eq Message.two_fa_empty
        end
      end

      context "when OTP Module is enabled with no token" do
        before(:each) do
          @request.env["devise.mapping"] = Devise.mappings[:user]
          @user = create(:confirmed_user)
          @user.otp_module = "enabled"
          @user.save
          post :create, params: { user: { email: @user.email, password: "12345678", otp_code_token: '1234' } }
        end
  
        it "redirects to root_path" do
          expect(response).to redirect_to root_path
        end
  
        it "shows invalid 2FA code message" do
          expect(flash[:alert]).to eq Message.two_fa_wrong
        end
      end
    end
  end
end
