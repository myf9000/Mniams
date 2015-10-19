class AddS < ActiveRecord::Migration
  def change
  	 add_column :comments, :mniam_id, :integer
    add_index :comments, :mniam_id
    add_column :comments, :user_id, :integer
    add_index :comments, :user_id
  end
end
