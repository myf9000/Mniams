class RemoveConfirmation < ActiveRecord::Migration
  def change
  	 remove_column :users, :confirmable 
  end
end
