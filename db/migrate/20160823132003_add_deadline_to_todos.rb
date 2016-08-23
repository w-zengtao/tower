class AddDeadlineToTodos < ActiveRecord::Migration[5.0]
  def change
    add_column :todos, :deadline, :date
  end
end
