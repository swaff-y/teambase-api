class AddDueDateToTasksB < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :due_date, :bigint
  end
end
