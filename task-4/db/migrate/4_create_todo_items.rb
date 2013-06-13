class CreateTodoItems < ActiveRecord::Migration
    def change
        create_table :todo_items do |t|
            t.string :title
            t.string :description
            t.string :date_due
            t.integer :todo_list_id
        end
    end
end
