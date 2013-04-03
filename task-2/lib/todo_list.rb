class TodoList

  # Initialize the TodoList with +items+ (empty by default).

  def initialize(parameters=[])
    @network = parameters[:social_network]
    @parameters = parameters
    raise IllegalArgument if parameters[:db].nil?
    
   end

  
  def empty?
    @parameters[:db].items_count == 0
  end
  
  def size
    @parameters[:db].items_count
  end
  
  def << (item)
    return nil if item == nil
    if item[:title] == "" || item[:title].length <6
      false
    else
      @parameters[:db].add_todo_item(item)
      if @network
        item.title = item.title[0 .. 254] if item.title.length >= 255
        @network.spam(item)
      end
    end
  end
  
  def first
    @parameters[:db].get_todo_item(0)
  end
  
  def last
    size = @parameters[:db].items_count
    if size == 0
      @parameters[:db].get_todo_item(size)
    else
      number = size-1
      @parameters[:db].get_todo_item(number)
    end
  end

  def toggle_state (index)
    item = @parameters[:db].get_todo_item(index)

    if item == nil
      raise IllegalArgument
    else
      if @parameters[:db].todo_item_completed?(index) == false
        @parameters[:db].complete_todo_item(index,true)
        if @network
          item.title = item.title[0 .. 254] if item.title.length >= 255
          @network.spam(item)
        end
      else
        @parameters[:db].complete_todo_item(index,false)
      end
    end
  end

end
