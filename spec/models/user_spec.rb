require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it "is valid with default valid attributes" do
    expect(user).to be_valid
  end

  describe "email validations" do
    it { should validate_presence_of(:email) }

    it "should respond to email" do
      expect(user).to respond_to(:email)
    end

    it "is invalid with a blank or no email" do
      user.email = " "
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end
    
    it "is invalid without a proper email" do
      user.email = "a"
      user.valid?
      expect(user.errors[:email]).to include("is invalid")
    end
    
    it "is invalid with a duplicate email" do
      user.save
      @otheruser = FactoryBot.build(:user, email: user.email)
      @otheruser.valid?
      expect(@otheruser.errors[:email]).to include("has already been taken")
    end
  end

  describe "password validations" do
    it { should validate_presence_of(:password) }

    it "should respond to password" do
      expect(user).to respond_to(:password)
    end
    
    it "should respond to password_confirmation" do
      expect(user).to respond_to(:password_confirmation)
    end

    it "is invalid without same password for password_confirmation" do
      user.password_confirmation = "xxxxx"
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
    
    it "is invalid with password length < 8" do
      user.password = "123456"
      user.password_confirmation = "123456"
      user.valid?
      expect(user.errors[:password][0]).to include("is too short")
    end
    
    it "is invalid with password length > 80" do
      user.password = Faker::Lorem.characters(number: 81)
      user.password_confirmation = user.password
      user.valid?
      expect(user.errors[:password][0]).to include("is too long")
    end

    it "should have encrypted password + not eq to password" do
      expect(user.password).not_to eq user.encrypted_password
    end
  end

  describe "username validations" do
    it { should validate_presence_of(:username) }

    it "should respond to username" do
      expect(user).to respond_to(:username)
    end

    it "is invalid with a blank username" do
      user.username = " "
      user.valid?
      expect(user.errors[:username]).to include("can't be blank")
    end

    it "is invalid with no username" do
      user.username = nil
      user.valid?
      expect(user.errors[:username]).to include("can't be blank")
    end

    it "is invalid with a duplicate username" do
      user.save
      @otheruser = FactoryBot.build(:user, username: user.username)
      @otheruser.valid?
      expect(@otheruser.errors[:username]).to include("has already been taken")
    end

    it "is invalid if length is < 3" do
      user.username = "ab"
      user.valid?
      expect(user.errors[:username]).to include("is too short (minimum is 3 characters)")
    end

    it "is invalid if length is > 10" do
      user.username = "abcdefghijk"
      user.valid?
      expect(user.errors[:username]).to include("is too long (maximum is 10 characters)")
    end

    it "downcases username" do
      user.username = "ABCdeF"
      user.save
      expect(user.username).to eq "abcdef"
    end

    it "is invalid for bad username" do
      user.username = "ABC_E."
      user.valid?
      expect(user.errors[:username]).to include("is invalid")
    end
  end
end
