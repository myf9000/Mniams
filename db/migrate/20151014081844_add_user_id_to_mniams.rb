class AddUserIdToMniams < ActiveRecord::Migration
  def change
    add_column :mniams, :user_id, :integer
  end
end
