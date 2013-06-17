require_relative 'test_helper'
require_relative '../lib/user'

describe User do
  include TestHelper

    subject(:user)                  { User.create(name: name, surname: surname, email: email, password: password, password_confirmation: password_confirmation, terms_of_the_service: terms_of_the_service) }
    let(:name)                      { "Stefan" }
    let(:surname)                   { "Kowalski" }
    let(:email)                     { "khalosh@gmail.com" }
    let(:password)                  { "0123456789qwerty" }
    let(:password_confirmation)     { "0123456789qwerty" }
    let(:terms_of_the_service)          { true }
    
  it "should have valid attributes" do
     user.should be_valid
  end
    
  context "with empty name" do
     let(:name) { nil }
     it { should_not be_valid }
  end
    
  context "with too long name" do
     let(:name) { "asdasdasdasdasdasdasdasdasasdasdasdasdasdasdasdasdasdasdasdasdasdasdasd" }
     it { should_not be_valid }
  end
    
    context "with empty surname" do
        let(:surname) { nil }
        it { should_not be_valid }
    end
    
    context "with too long surname" do
        let(:surname) { "asdasdasdasdasdasdasdasdasasdasdasdasdasdasdasdasdasdasdasdasdasdasdasd" }
        it { should_not be_valid }
    end
    
    context "with too short password" do
        let(:password) { "123" }
        it { should_not be_valid }
    end
    
    context "with unconfirmed password" do
        let(:password)                  { "0123456789qwerty" }
        let(:password_confirmation)     { "0123456789qwer456456ty" }
        it { should_not be_valid }
    end
    
    context "with unacepted terms of the service" do
        let(:terms_of_the_service) { false }
        it { should_not be_valid }
    end

    it "should have failed_login_count = 0" do
        user.failed_login_count.should == 0
    end
   
  context "with invalid email" do
      let(:email) { "khalosh.gmail.com" }
      it { should_not be_valid }
  end


  it "should find user by surname" do
    user = User.find_by_surname("Statham")
    user.surname.should == "Statham"
    user.name.should == "Jason"
  end

  it "should find user by email" do
    user = User.find_by_email("djmicros@gmail.com")
    user.surname.should == "Kuciel"
    user.name.should == "Adrian"
  end

  it "should authenticate user using email and password (should use password encryption)" do 
     User.authenticate("djmicros@gmail.com", "qwerty12345").should == true
  end

  it "should find suspicious users with more than 2 failed_login_counts" do
    User.authenticate("djmicros@gmail.com", "zxcv")
    User.authenticate("djmicros@gmail.com", "qwer")
    User.authenticate("djmicros@gmail.com", "asdf")
    User.find_by_email("djmicros@gmail.com").failed_login_count.should == 3
    User.find_suspicious_users.count.should == 3
  end
    
  it "should group users by failed_login_counts" do
    User.group_suspicious_users.count.should == {0=>1, 4=>2}
  end
    
  it "find user by prefix of his/her surname" do
    User.find_by_prefix("Kuci").surname.should == "Kuciel"
  end
end
