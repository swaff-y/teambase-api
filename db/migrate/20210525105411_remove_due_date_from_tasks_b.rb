class RemoveDueDateFromTasksB < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :due_date, :integer
  end
end
