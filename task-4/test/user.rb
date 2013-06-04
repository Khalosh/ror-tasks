require_relative 'test_helper'
require_relative '../lib/user'

describe User do
  include TestHelper

  subject(:user)  { User.create(name: 'Stefan', surname: "Kowalski", 
terms_of_service: true, password: "dsjnasesajkfdsjklf" )}

  it "should have a non-empty name up to 20 characters long" do
     user.name.length.should <= 20
  end

  it "should have a non-empty surname up to 30 characters long" do
     user.surname.length.should <= 30
  end

  it "should accept the terms of the service" do
     user.terms_of_service.should == true
  end

  it "should have non-empty password" do
     user.password.length >= 10
  end

  context 'invlid params' do
    subject(:user) { User.new(name: 'asdfghjklzxcvbnmqwert', surname: 
'qwertyuiopasdfghjklzxcvbnmqwerty', terms_of_service: true, password: 
"asda") }
    
    it 'ss' do
      user.should_not be_valid
    end
  end
end
