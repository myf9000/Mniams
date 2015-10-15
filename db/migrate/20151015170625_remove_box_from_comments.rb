class RemoveBoxFromComments < ActiveRecord::Migration
  def change
  	remove_column :comments, :box
  end
end
