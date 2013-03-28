class TodoList

  class Item
  attr_accessor :description, :completed

    def initialize(description=nil)
      @description = description
      @completed = false
    end
    
    def to_s
      @description.to_s
    end

    def format
      if @completed
        completion = "x"
      else
        completion = " "
      end
      "- [#{completion}] #{@description}"
    end

  end

  # Initialize the TodoList with +items+ (empty by default).
  def initialize(items=[])
    raise IllegalArgument if items.nil?
    @items = []
      items.each do |item|
        @items.push Item.new(item)
      end
  end

  def size
    @items.size
  end

  def item(index)
    @items[index]
  end

  def completed?(index)
    @items[index].completed
  end

  def complete(index)
    @items[index].completed = true
  end

  def completed 
    @items.select { |item| item.completed }
  end

  def uncomplete(index)
    @items[index].completed = false
  end

  def uncompleted
    @items.select { |item| !item.completed }
  end

  def remove(index)
    @items.delete_at(index)
  end

  def remove_completed
    @items.reject! { |item| item.completed }
  end

  def reverse(one, two)
    first = @items[one]
    second = @items[two]
    @items[one] = second
    @items[two] = first
  end

  def reverse_all
    @items.reverse!
  end

  def sort
    @items.sort! { |a,b| a.description <=> b.description }
  end

  def to_s
    (@items.collect { |item| item.format }).join("\n")
  end

  def toggle(index)
    if @items[index].completed
      @items[index].completed = false
    else
      @items[index].completed = true
    end
  end

  def change_desc(index, desc)
    @items[index].description = desc
  end

  def empty?
    @items.empty?
  end

  def << (item)
    @items.push(Item.new(item))
  end

  def last
    @items.last
  end

  def first
    @items.first
  end
    
end
