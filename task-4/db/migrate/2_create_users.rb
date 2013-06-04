class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :password
      t.integer :failed_login_count
      t.boolean :terms_of_service
    end
  end
end
