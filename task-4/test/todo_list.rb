require_relative 'test_helper'
require_relative '../lib/todo_list'

describe TodoList do
  include TestHelper
    
    subject(:list)    { TodoList.create(title: title, user_id: user_id) }
    let(:title)       { "Some title" }
    let(:user_id)        { 1 }
    
  it "should pass validation" do
    list.should be_valid
  end
    
  context "with empty title" do
    let(:title) { "" }
    it { should_not be_valid }
  end
    
  context "without attribute user_id" do
     let(:user_id) { nil }
     it { should_not be_valid }
  end
end


