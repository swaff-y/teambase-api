class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :status
      t.integer :progress
      t.text :description
      t.date :due_date
      t.integer :priority
      t.integer :project_category_id

      t.timestamps
    end
  end
end
