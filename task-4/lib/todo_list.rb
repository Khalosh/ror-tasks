require 'active_record'

class TodoList < ActiveRecord::Base
  belongs_to :user
  has_many :todo_items
  validates :title, :user_id, presence: true


  def self.find_by_prefix (prefix)
    where("lower(title) LIKE '#{prefix.downcase}%'")
  end

  def self.find_by_user (user)
    where(user_id: user.id)
  end

  def self.find_and_load_items (id)
    where(id: id).includes(:todo_items).first
  end

end