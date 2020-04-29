shared_examples 'when user is not logged in' do |action|
  before(:each) do
    if action == '/feeds'
      get :index
    elsif action == '/feed/:id/delete'
      @feed1 = create(:feed, user: user)
      delete :destroy, params: { id: @feed1.id }
    elsif action == '/feed/:id/public'
      @feed1 = create(:feed, user: user)
      patch :public, params: { id: @feed1.id }
    elsif action == '/feed/:id/private'
      @feed1 = create(:feed, user: user, public: true)
      patch :private, params: { id: @feed1.id }
    elsif action == '/users/verify_enable'
      @user1 = create(:confirmed_user)
      post :verify_enable, params: { id: @user1.id, multi_factor_authentication: { otp_code_token: @user1.otp_code } }
    elsif
      @user1 = create(:confirmed_user)
      post :verify_disable, params: { id: @user1.id, multi_factor_authentication: { otp_code_token: @user1.otp_code } }
    end
  end

  it "redirects to new_user_session_path" do
    expect(response).to redirect_to new_user_session_path
  end

  it "shows login message" do
    expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
  end
end