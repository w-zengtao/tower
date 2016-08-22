class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :content
      t.references :commentable, :polymorphic => true
      t.references :user

      t.timestamps
    end
  end
end
