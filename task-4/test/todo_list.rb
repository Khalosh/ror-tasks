require_relative 'test_helper'
require_relative '../lib/todo_list'

describe TodoList do
  include TestHelper

  it "should have a non-empty title" do
    TodoList.create(:title => "Some title")
    TodoList.title.should == "Some title"
  end
end


