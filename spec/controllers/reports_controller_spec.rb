require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  let(:user) { create(:confirmed_user) }
  let(:report) { create(:report, user: user) }

  ## GET /reports/:id
  describe "GET #show" do
    context "show /reports/:id" do
      before(:each) do
        get :show, params: { id: report.id }
      end

      it "renders show page" do
        expect(response).to render_template(:show)
      end

      it "assigns report" do
        expect(assigns(:report)).to eq report
      end
    end
  end

  ## GET /r/:username?feed_content=abcdefghijkl
  ## GET /r/:admin
  describe "GET #report" do
    context "show /r/:username" do
      context "for feed_content reports" do
        before(:each) do
          get :report, params: { username: user.username, feed_content: "abcdefghijkl" }
        end
  
        it "renders report page" do
          expect(response).to render_template(:report)
        end
  
        it "assigns feed_content from params" do
          expect(assigns(:feed_content)).to eq "abcdefghijkl"
        end
      end

      context "for other reports in name of admin" do
        before(:each) do
          @user1 = create(:confirmed_user)
          @user1.admin = true
          @user1.save
          @user1.reload
          ENV["admin_username"] = @user1.username
          get :report, params: { username: @user1.username }
        end

        after(:each) do
          ENV["admin_username"] = ""
        end
  
        it "renders report page" do
          expect(response).to render_template(:report)
        end
      end
    end

    context "cannot /r/:username" do
      context "if feed_content param is not present" do
        before(:each) do
          get :report, params: { username: user.username }
        end
  
        it "renders root_path" do
          expect(response).to redirect_to root_path
        end
  
        it "renders alert message" do
          expect(flash[:alert]).to eq Message.feed_content_not_found
        end
      end

      context "if username is not in the database" do
        before(:each) do
          get :report, params: { username: 'xxxxxx' }
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
          get :report, params: { username: @user1.username }
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

  ## POST /reports
  describe "POST #create" do
    context "creates report successfully" do
      before(:each) do
        @report1 = build(:report, user: user)
        @report1.content = "1234567891011"
        request.env['HTTP_REFERER'] = "/r/#{@report1.user.username}"
      end

      it "create report and adds to the database" do
        expect { post :create, params: { report: { content: @report1.content } } }.to change(Report, :count).by(1)
      end

      it "redirects to root_path" do
        post :create, params: { report: { content: @report1.content } }
        expect(response).to redirect_to report_path(Report.last.id)
      end

      it "renders successful report created message" do
        post :create, params: { report: { content: @report1.content } }
        expect(flash[:notice]).to eq Message.report_created 
      end
    end

    context "cannot create report" do
      context "if content length is invalid" do
        before(:each) do
          @report1 = build(:report, user: user)
          @report1.content = "1234"
          request.env['HTTP_REFERER'] = "/r/#{@report1.user.username}"
          post :create, params: { report: { content: @report1.content } }
        end
  
        it "redirects to ref_path" do
          expect(response).to redirect_to "/r/#{@report1.user.username}"
        end
  
        it "renders content problem message" do
          expect(flash[:alert]).to eq Message.feed_content_not_found
        end
      end
    end
  end
end
