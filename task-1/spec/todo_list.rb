require 'bundler/setup'
require 'rspec/expectations'
require_relative '../lib/todo_list'
require_relative '../lib/exceptions'

describe TodoList do
  subject(:list)            { TodoList.new(items) }
  let(:items)               { [] }
  let(:item_description)    { "Buy toilet paper" }
  let(:second_item_description) { "Buy oranges" }
  let(:third_item_description)  { "Cook the potatoes" }

  it { should be_empty }

  it "should raise an exception when nil is passed to the constructor" do
    expect { TodoList.new(nil) }.to raise_error(IllegalArgument)
  end

  it "should have size of 0" do
    list.size.should == 0
  end

  it "should accept an item" do
    list << item_description
    list.should_not be_empty
  end

  it "should add the item to the end" do
    list << item_description
    list.last.to_s.should == item_description
  end

  it "should have the added item uncompleted" do
    list << item_description
    list.completed?(0).should be_false
  end

  context "with one item" do
    let(:items)             { [item_description] }

    it { should_not be_empty }

    it "should have size of 1" do
      list.size.should == 1
    end

    it "should have the first and the last item the same" do
      list.first.to_s.should == list.last.to_s
    end

    it "should not have the first item completed" do
      list.completed?(0).should be_false
    end

    it "should allow to access the item by index" do
      list[0].should.to_s.should == item_description
    end
  end

  context "with many items" do
    let(:items)               { [item_description, 
second_item_description, third_item_description] }
   
    it "should return completed items" do
     list.complete(0)
     list.completed.to_s.should == "["+list.item(0).to_s+"]"
    end

    it "should return uncompleted items" do
      list.complete(0)
      list.complete(2)
      list.uncompleted.to_s.should == "["+list.item(1).to_s+"]"
    end

    it "should remove an individual item" do
      list.remove(0)
      list.item(0).to_s.should == second_item_description.to_s
    end
    
    it "should remove completed items" do
      list.complete(0)
      list.complete(1)
      list.remove_completed.to_s.should == "["+third_item_description.to_s+"]"
    end

    it "should reverse order of two items" do
      first = list.item(0)
      second = list.item(1)
      list.reverse(0,1)
      first.should == list.item(1)
      second.should == list.item(0)
    end

    it "should reverse all items" do
      items = []
      for i in (0...list.size) do
        items.push(list.item(i))
      end
      list.reverse_all
      for i in (0...list.size) do
        items[items.size - i - 1].to_s.should == list.item(i).to_s
      end
    end

    it "should toggle state of an item" do
      list.toggle(0)
      list.completed?(0).should be_true
      list.toggle(0)
      list.completed?(0).should be_false
    end

    it "should make item uncompleted" do
      list.complete(0)
      list.uncomplete(0)
      list.completed?(0).should be_false
    end

    it "should change the description of an item" do
      list.change_desc(0, "New description")
      list.item(0).description.should == "New description"
    end

    it "should sort items by name" do
      list.sort
      for i in (0...(list.size - 1)) do
        list.item(i).to_s.should <= list.item(i + 1).to_s
      end
    end

    it "should convert the list to text with the following format:\n- [ ] Uncompleted item\n- [x] Completed item" do
      list.complete(1)
      list.to_s.should == "- [ ] #{item_description}\n- [x] #{second_item_description}\n- [ ] #{third_item_description}"
    end

  end
end
