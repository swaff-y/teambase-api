class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.date :start_date
      t.string :status
      t.text :description
      t.integer :project_id
      t.integer :progress
      t.integer :task_category_id
      t.date :due_date
      t.integer :priority

      t.timestamps
    end
  end
end
