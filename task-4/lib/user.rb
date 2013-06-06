require 'active_record'

class User < ActiveRecord::Base
    
    attr_accessible :surname, :name, :password, :email,
    :password_confirmation, :terms_of_the_service
    
  has_many :todo_lists
  has_many :todo_items, :through => :todo_lists
   
    validates :name, :surname, :password_confirmation, presence: true
    validates :password, confirmation: true
    validates :password, length: { minimum: 10 }
    validates :name, length: { maximum: 20 }
    validates :surname, length: { maximum: 30 }
    validates :email, :format => { :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i }
    validates :terms_of_the_service, acceptance: { accept: true }, allow_nil: false
end
