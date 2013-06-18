require 'active_record'
require 'sqlite3_ar_regexp'

class TodoItem < ActiveRecord::Base
    
  belongs_to :todo_list
  validates :title, :todo_list_id, presence: true  
  validates :title, length: { minimum: 5, maximum: 30 }
  validates :description, length: { maximum: 255 }
  validate :date_due_format, allow_nil: true
    
    
    
  def self.find_by_word (word)
    where("description REGEXP ?", "(^|[^A-Za-z0-9_])#{word}([^A-Za-z0-9_]|$)").first
  end

  def self.with_long_description
    where("LENGTH(description) > 100").first
  end

  def self.paginate(index)
    order("title").offset(5 * (index - 1)).limit(5)
  end

  def self.find_all_by_user(user)
    user_id = user.id
    joins(:todo_list).where("todo_lists.user_id = ?", user_id)
  end

  def self.find_by_day(date)
    where("date_due = ?", Time.parse(date))
  end



  def date_due=(date)
    @date = date
    super(date)
  end

protected

  def date_due_format
    errors.add(:date_due, 'must be a valid date with dd/mm/yyyy format') if @date && ((DateTime.strptime(@date, "%d/%m/%Y") rescue ArgumentError) == ArgumentError)
    true
  end
end
