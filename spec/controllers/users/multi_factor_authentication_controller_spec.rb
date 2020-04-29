require 'rails_helper'

RSpec.describe Users::MultiFactorAuthenticationController, type: :controller do
  let(:user) { create(:confirmed_user) }

  describe "POST #verify_enable" do
    context "when successfully enabled" do
      before(:each) do
        sign_in user
        post :verify_enable, params: { id: user.id, multi_factor_authentication: { otp_code_token: user.otp_code } }
      end

      it "redirects to edit_user_registration_path" do
        expect(response).to redirect_to edit_user_registration_path
      end

      it "shows 2fa enabled message" do
        expect(flash[:notice]).to eq Message.two_fa_enabled
      end
    end

    context "when could not be enabled" do
      context "when otp_code is empty" do
        before(:each) do
          sign_in user
          post :verify_enable, params: { id: user.id, multi_factor_authentication: { otp_code_token: '' } }
        end
  
        it "redirects to edit_user_registration_path" do
          expect(response).to redirect_to edit_user_registration_path
        end
  
        it "shows 2fa not enabled message" do
          expect(flash[:alert]).to eq Message.two_fa_not_enabled
        end
      end

      context "when otp_code is wrong" do
        before(:each) do
          sign_in user
          post :verify_enable, params: { id: user.id, multi_factor_authentication: { otp_code_token: '123456' } }
        end
  
        it "redirects to edit_user_registration_path" do
          expect(response).to redirect_to edit_user_registration_path
        end
  
        it "shows 2fa not enabled message" do
          expect(flash[:alert]).to eq Message.two_fa_not_enabled
        end
      end

      context "cannot access/manage 2fa settings" do
        it_behaves_like 'when user is not logged in', '/users/verify_enable'
      end
    end
  end

  describe "POST #verify_disabled" do
    context "when successfully disabled" do
      before(:each) do
        sign_in user
        post :verify_disable, params: { id: user.id, multi_factor_authentication: { otp_code_token: user.otp_code } }
      end

      it "redirects to edit_user_registration_path" do
        expect(response).to redirect_to edit_user_registration_path
      end

      it "shows 2fa enabled message" do
        expect(flash[:notice]).to eq Message.two_fa_disabled
      end
    end

    context "when could not be disabled" do
      context "when otp_code is empty" do
        before(:each) do
          sign_in user
          post :verify_disable, params: { id: user.id, multi_factor_authentication: { otp_code_token: '' } }
        end
  
        it "redirects to edit_user_registration_path" do
          expect(response).to redirect_to edit_user_registration_path
        end
  
        it "shows 2fa not disabled message" do
          expect(flash[:alert]).to eq Message.two_fa_not_disabled
        end
      end

      context "when otp_code is wrong" do
        before(:each) do
          sign_in user
          post :verify_disable, params: { id: user.id, multi_factor_authentication: { otp_code_token: '123456' } }
        end
  
        it "redirects to edit_user_registration_path" do
          expect(response).to redirect_to edit_user_registration_path
        end
  
        it "shows 2fa not disabled message" do
          expect(flash[:alert]).to eq Message.two_fa_not_disabled
        end
      end

      context "cannot access/manage 2fa settings" do
        it_behaves_like 'when user is not logged in', '/users/verify_disable'
      end
    end
  end
end
