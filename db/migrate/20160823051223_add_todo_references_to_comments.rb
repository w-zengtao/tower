class AddTodoReferencesToComments < ActiveRecord::Migration[5.0]
  def change
    add_reference :comments, :todo
  end
end
