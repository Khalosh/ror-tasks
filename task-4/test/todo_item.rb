require_relative 'test_helper'
require_relative '../lib/todo_item'

describe TodoItem do
    include TestHelper
    
    subject(:item)        { TodoItem.create(title: title, date_due: date_due, todo_list_id: todo_list_id, description: description) }
    let(:title)           { "Dorszlol" }
    let(:date_due)        { nil }
    let(:todo_list_id)    { 1 }
    let(:description)     { nil }
    
    it "should pass validation" do
      item.should be_valid
    end
    
    it "should have a list it belongs to" do
      item.todo_list_id.should == 1
    end
    
    context "with valid date_due given" do
      let(:date_due) { "01/01/1992" }
      it { should be_valid }
    end
    
    context "with invalid date_due given" do
      let(:date_due) { "24234/234-234" }
      it { should_not be_valid }
    end
    
    context "without given todo_list_id" do
      let(:todo_list_id) { nil }
      it { should_not be_valid }
    end
    
    context "with too short title" do
      let(:title) { "abc" }
      it { should_not be_valid }
    end
    
    context "with too long title" do
      let(:title) { "1234567890123456789012345678901234567890" }
      it { should_not be_valid }
    end
    
    context "with too long description" do
    let(:description) { "Lorem ipsum dolor sit amet diam turpis sagittis urna. Donec consectetuer tincidunt, eros sagittis venenatis. Curabitur urna quis sollicitudin mi risus, pellentesque vel, varius egestas, nunc iaculis odio tellus wisi, aliquam dictum accumsan imperdiet, neque vitae felis. In euismod pulvinar, pede bibendum sapien eget odio. Quisque sit amet quam. Aliquam faucibus quis, tincidunt eget, dolor. Nulla faucibus non, placerat ut, metus. Maecenas eget urna. Cras interdum vehicula. Vivamus orci vitae erat volutpat. Ut fermentum nisl at nibh ut augue. Lorem ipsum aliquet molestie. Phasellus ut nulla. Integer condimentum lorem sodales turpis, rutrum sit amet augue. Pellentesque habitant morbi tristique luctus diam in consequat non, consectetuer ut, diam. Nam laoreet ut, dolor. Fusce urna eros bibendum varius felis sed dui. Nulla posuere quis, eleifend non, quam. Nam diam. Donec sit amet, est. Aliquam erat lacus, elementum congue, lorem semper magna sit amet, felis. Aliquam eget leo velit sit amet dignissim turpis. Morbi molestie, neque. In molestie tincidunt. Maecenas nisl neque auctor varius, felis vitae mauris. Etiam non enim molestie ultricies vehicula, dui quis leo. In sodales in, mollis neque tristique bibendum." }
      it { should_not be_valid }
    end
end

