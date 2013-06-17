require 'active_record'

class TodoItem < ActiveRecord::Base
    
  belongs_to :todo_list
  validates :title, :todo_list_id, presence: true  
  validates :title, length: { minimum: 5, maximum: 30 }
  validates :description, length: { maximum: 255 }
  validates :date_due, :format => { with: /\A\d{2}\/\d{2}\/\d{4}\z/ }, allow_nil: true
end
