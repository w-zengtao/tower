class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.references :user, null: true
      t.references :eventable, polymorphic: true, null: false
      t.string :act, null: false

      t.timestamps
    end
  end
end
