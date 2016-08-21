class AddStatusToAccesses < ActiveRecord::Migration[5.0]
  def change
    add_column :accesses, :status, :integer, default: 1
  end
end
