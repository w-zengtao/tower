class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.string :name
      t.integer :state, default: 0
      t.references :user
      t.references :project

      t.timestamps
    end
  end
end
