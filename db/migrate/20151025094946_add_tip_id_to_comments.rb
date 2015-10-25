class AddTipIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :tip_id, :integer
    add_index :comments, :tip_id
  end
end
