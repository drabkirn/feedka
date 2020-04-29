require 'rails_helper'

RSpec.describe Report, type: :model do
  let(:report) { create(:report) }

  it { should belong_to(:user) }

  it "is valid with default valid attributes" do
    expect(report).to be_valid
  end

  describe "content validation" do
    it { should validate_presence_of(:content) }

    it "should respond to content" do
      expect(report).to respond_to(:content)
    end

    it "is invalid with a blank or no content" do
      report.content = " "
      report.valid?
      expect(report.errors[:content]).to include("can't be blank")
    end

    it "is invalid if length is < 10" do
      report.content = "ab"
      report.valid?
      expect(report.errors[:content]).to include("is too short (minimum is 10 characters)")
    end

    it "is invalid if length is > 500" do
      report.content = Faker::Lorem.paragraph_by_chars(number: 501)
      report.valid?
      expect(report.errors[:content]).to include("is too long (maximum is 500 characters)")
    end

    it "encrypts the content after creating" do
      @report1 = build(:report, user: create(:confirmed_user))
      local_report1_content = @report1.content
      @report1.save
      expect(@report1.content).to_not eq local_report1_content
    end

    it "encrypts the content after updating" do
      @report1 = create(:report, user: create(:confirmed_user))
      local_report1_content = Encryption.decrypt_data(@report1.content)
      @report1.content = "This is a new content over here"
      @report1.save
      expect(@report1.content).to_not eq local_report1_content
    end
  end

  describe "message validation" do
    it "should respond to message" do
      expect(report).to respond_to(:message)
    end

    it "is invalid if length is > 500" do
      report.message = Faker::Lorem.paragraph_by_chars(number: 501)
      report.valid?
      expect(report.errors[:message]).to include("is too long (maximum is 500 characters)")
    end
  end

  describe "status validation" do
    it { should validate_presence_of(:status) }

    it { should define_enum_for(:status).with_values(pending: 0, rejected: 1, accepted: 2).with_prefix(true) }

    it "should respond to status" do
      expect(report).to respond_to(:status)
    end

    it "is invalid with a blank or no status" do
      report.status = " "
      report.valid?
      expect(report.errors[:status]).to include("can't be blank")
    end

    it "changes the states from pending to rejected" do
      report.status = 1
      report.save
      report.reload
      expect(report.status_rejected?).to eq true
    end

    it "changes the states from pending to accepted" do
      report.status = 2
      report.save
      report.reload
      expect(report.status_accepted?).to eq true
    end
  end
end
