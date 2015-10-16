class RemoveColumnsFromComments < ActiveRecord::Migration
  def change
  	remove_column :comments, :commentable_id
  	remove_column :comments, :commentable_type
  end
end
