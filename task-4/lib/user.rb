require 'active_record'

class User < ActiveRecord::Base
  has_many :todo_lists 
  has_many :todo_items, :through => :todo_lists
   
  validates :name, :surname, :password, :failed_login_count, presence: true
  validates :name, length: { maximum: 20 }
  validates :surname, length: { maximum: 30 }
  validates :password, confirmation: true
  
  validates :terms_of_service, acceptance: true
  validates :password, length: { minimum: 10 }
  validates :failed_login_count, numericality: { only_integer: true }
end
