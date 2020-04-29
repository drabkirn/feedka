require 'rails_helper'

RSpec.describe FeedsController, type: :controller do
  let(:user) { create(:confirmed_user) }
  let(:feed) { create(:feed, user: user) }

  ## GET /feeds
  describe "GET #index" do
    context "show /feeds" do
      before(:each) do
        sign_in user
        3.times { create(:feed, user: user) }
        get :index
      end

      it "renders index page" do
        expect(response).to render_template(:index)
      end

      it "assigns all feeds to users" do
        expect(assigns(:feeds)).to eq controller.current_user.feeds.order('updated_at DESC')
      end
    end

    context "cannot show /feeds" do
      it_behaves_like 'when user is not logged in', '/feeds'
    end
  end

  ## GET /f/:username
  describe "GET #feedback" do
    context "show /f/:username" do
      before(:each) do
        3.times { create(:feed, user: user, public: true) }
        get :feedback, params: { username: feed.user.username }
      end

      it "renders feedback page" do
        expect(response).to render_template(:feedback)
      end

      it "shows all public feeds" do
        public_feeds = []
        feed.user.feeds && feed.user.feeds.order("updated_at DESC").each do |f|
          public_feeds << f if f.public?
        end
        expect(assigns(:public_feeds)).to eq public_feeds
      end
    end

    context "cannot /f/:username" do
      context "if username is not in the database" do
        before(:each) do
          get :feedback, params: { username: 'xxxxxx' }
        end

        it "redirects to root_path" do
          expect(response).to redirect_to root_path
        end
      
        it "shows user not found message" do
          expect(flash[:alert]).to eq Message.user_not_found
        end
      end

      context "if user has not confirmed the email" do
        before(:each) do
          @user1 = create(:user)
          get :feedback, params: { username: @user1.username }
        end

        it "redirects to root_path" do
          expect(response).to redirect_to root_path
        end
      
        it "shows user email not confirmed message" do
          expect(flash[:alert]).to eq Message.user_email_not_confirmed
        end
      end
    end
  end

  ## POST /feeds
  describe "POST #create" do
    context "creates feed successfully" do
      before(:each) do
        @feed1 = build(:feed, user: user)
        @feed1.content = "1234567891011"
        request.env['HTTP_REFERER'] = "/f/#{@feed1.user.username}"
      end

      it "create feed and adds to the database" do
        Sidekiq::Testing.inline! do
          expect { post :create, params: { feed: { content: @feed1.content } } }.to change(Feed, :count).by(1)
        end
      end

      it "redirects to root_path" do
        post :create, params: { feed: { content: @feed1.content } }
        expect(response).to redirect_to root_path
      end

      it "renders successful feed created message" do
        post :create, params: { feed: { content: @feed1.content } }
        expect(flash[:notice]).to eq Message.feed_created 
      end
    end

    context "cannot create feed" do
      context "feed content contains PII info" do
        before(:each) do
          @feed1 = build(:feed, user: user)
          @feed1.content = "This has PII info - abcd@google.com"
          request.env['HTTP_REFERER'] = "/f/#{@feed1.user.username}"
          post :create, params: { feed: { content: @feed1.content } }
        end
  
        it "redirects to submit report path" do
          expect(response).to redirect_to submit_report_path(username: @feed1.user.username, feed_content: @feed1.content)
        end
  
        it "renders error PII message" do
          expect(flash[:custom_alert]).to include Message.pii_info_found
        end
      end

      context "feed content contains abuse" do
        before(:each) do
          @feed1 = build(:feed, user: user)
          @feed1.content = "This has Abuse info - crap"
          request.env['HTTP_REFERER'] = "/f/#{@feed1.user.username}"
          post :create, params: { feed: { content: @feed1.content } }
        end
  
        it "redirects to submit report path" do
          expect(response).to redirect_to submit_report_path(username: @feed1.user.username, feed_content: @feed1.content)
        end
  
        it "renders error abuse message" do
          expect(flash[:custom_alert]).to include Message.abuse_found
        end
      end

      context "Content moderation URL error" do
        before(:each) do
          @feed1 = build(:feed, user: user)
          @feed1.content = "The URL of API is wrong"
          request.env['HTTP_REFERER'] = "/f/#{@feed1.user.username}"
          post :create, params: { feed: { content: @feed1.content } }
        end
  
        it "redirects to root_path" do
          expect(response).to redirect_to root_path
        end
  
        it "renders error url message" do
          expect(flash[:custom_alert]).to include Message.api_error
        end
      end

      context "Content moderation other error" do
        before(:each) do
          @feed1 = build(:feed, user: user)
          @feed1.content = "Content moderation other error"
          request.env['HTTP_REFERER'] = "/f/#{@feed1.user.username}"
          post :create, params: { feed: { content: @feed1.content } }
        end
  
        it "redirects to root_path" do
          expect(response).to redirect_to root_path
        end
  
        it "renders error url message" do
          expect(flash[:custom_alert]).to include "Content moderation other error"
        end
      end

      context "if feed content has some error" do
        before(:each) do
          @feed1 = build(:feed, user: user)
          @feed1.content = "123"
          request.env['HTTP_REFERER'] = "/f/#{@feed1.user.username}"
          post :create, params: { feed: { content: @feed1.content } }
        end
  
        it "redirects to ref_path" do
          expect(response).to redirect_to "/f/#{@feed1.user.username}"
        end
  
        it "renders feed params error message" do
          expect(flash[:custom_alert]).to include "Content is too short (minimum is 10 characters)"
        end
      end
    end
  end

  ## PATCH /feed/:id/public
  describe "PATCH #public" do
    context "make feed public" do
      before(:each) do
        sign_in user
        @feed1 = create(:feed, user: user)
        patch :public, params: { id: @feed1.id }
      end

      it "makes feed public" do
        @feed1.reload
        expect(@feed1.public?).to eq true
      end

      it "redirects to feeds #index" do
        expect(response).to redirect_to feeds_path
      end

      it "shows feed made public message" do
        expect(flash[:notice]).to eq Message.feed_public
      end
    end

    context "cannot make feed public /feed/:id/public" do
      it_behaves_like 'when user is not logged in', '/feed/:id/public'
    end
  end

  ## PATCH /feed/:id/private
  describe "PATCH #private" do
    context "make feed private" do
      before(:each) do
        sign_in user
        @feed1 = create(:feed, user: user, public: true)
        patch :private, params: { id: @feed1.id }
      end

      it "makes feed private" do
        @feed1.reload
        expect(@feed1.public?).to eq false
      end

      it "redirects to feeds #index" do
        expect(response).to redirect_to feeds_path
      end

      it "shows feed made private message" do
        expect(flash[:notice]).to eq Message.feed_private
      end
    end

    context "cannot make feed private /feed/:id/private" do
      it_behaves_like 'when user is not logged in', '/feed/:id/private'
    end
  end

  ## DELETE /feed/:id
  describe "DELETE #destroy" do
    context "delete feed" do
      before(:each) do
        sign_in user
        3.times { create(:feed, user: user) }
        @feed1 = create(:feed, user: user)
      end

      it "deletes the feed from the database" do
        expect {
          delete :destroy, params: { id: @feed1.id }
        }.to change(Feed, :count).by(-1)
      end

      it "redirects to feeds #index" do
        delete :destroy, params: { id: @feed1.id }
        expect(response).to redirect_to feeds_path
      end
    end

    context "cannot delete /feed/:id" do
      it_behaves_like 'when user is not logged in', '/feed/:id/delete'
    end
  end
end
