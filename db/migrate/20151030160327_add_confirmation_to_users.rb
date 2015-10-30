class AddConfirmationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :confirmable, :string
    add_column :users, :confirmation_token, :string
    add_index :users, :confirmation_token,   :unique => true
  end
end
