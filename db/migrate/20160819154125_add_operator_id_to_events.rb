class AddOperatorIdToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :operator_id, :integer, null: false
    add_index :events, :operator_id
  end
end
