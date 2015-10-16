class RemoweFromComments < ActiveRecord::Migration
  def change
  	remove_index :comments, :ancestry
    remove_column :comments, :ancestry
  end
end
