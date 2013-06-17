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
    
  it "find list by prefix of the title" do
    TodoList.find_by_prefix("Druga").first.title.should == "Druga lista"
  end
    
  it "find all lists that belong to a given User" do
    TodoList.find_by_user(User.find_by_surname("Kuciel")).count.should == 2
  end

  it "should find list by id and egearly load its items" do
    list = TodoList.find_and_load_items(1)
    list.title.should == "Pierwsza lista"
    list.todo_items.count.should == 3
  end
end


