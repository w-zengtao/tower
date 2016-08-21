class CreateAccesses < ActiveRecord::Migration[5.0]
  def change
    create_table :accesses do |t|
      t.references :project
      t.references :user
      t.string :level, default: 'default'

      t.timestamps
    end
  end
end
