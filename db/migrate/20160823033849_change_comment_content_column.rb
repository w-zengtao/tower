class ChangeCommentContentColumn < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      change_table :comments do |t|
        dir.up { t.change :content, :text }
        dir.down { t.change :content, :string }
      end
    end
  end
end
