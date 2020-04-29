require 'rails_helper'

RSpec.describe Feed, type: :model do
  let(:feed) { create(:feed) }
  let(:user) { create(:user) }

  it "is valid with default valid attributes" do
    expect(feed).to be_valid
  end

  it { should belong_to(:user) }

  describe "content validation" do
    it { should validate_presence_of(:content) }

    it "should respond to content" do
      expect(feed).to respond_to(:content)
    end

    it "is invalid with a blank or no content" do
      feed.content = " "
      feed.valid?
      expect(feed.errors[:content]).to include("can't be blank")
    end

    it "is invalid if length is < 10" do
      feed.content = "ab"
      feed.valid?
      expect(feed.errors[:content]).to include("is too short (minimum is 10 characters)")
    end

    it "is invalid if length is > 500" do
      feed.content = Faker::Lorem.paragraph_by_chars(number: 501)
      feed.valid?
      expect(feed.errors[:content]).to include("is too long (maximum is 500 characters)")
    end

    it "encrypts the content after creating" do
      @feed1 = build(:feed, user: create(:confirmed_user))
      local_feed1_content = @feed1.content
      @feed1.save
      expect(@feed1.content).to_not eq local_feed1_content
    end

    it "encrypts the content after updating" do
      @feed1 = create(:feed, user: create(:confirmed_user))
      local_feed1_content = Encryption.decrypt_data(@feed1.content)
      @feed1.content = "This is a new content over here"
      @feed1.save
      expect(@feed1.content).to_not eq local_feed1_content
    end
  end

  describe "Invalid" do
    context "is invalid if user associated is not confirmed" do
      before(:each) do
        @feed1 = build(:feed, user: user)
      end

      it "is invalid" do
        expect(@feed1).to_not be_valid
      end

      it "shows invalid message" do
        @feed1.valid?
        expect(@feed1.errors[:user][0]).to include Message.user_email_not_confirmed
      end
    end
  end
end
