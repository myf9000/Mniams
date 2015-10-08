class AddMniamIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :mniam_id, :integer
    add_index :comments, :mniam_id
  end
end
