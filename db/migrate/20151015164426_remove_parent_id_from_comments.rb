class RemoveParentIdFromComments < ActiveRecord::Migration
  def change
  	remove_column :comments, :parent_id
  	remove_column :comments, :mniams_id
  end
end
