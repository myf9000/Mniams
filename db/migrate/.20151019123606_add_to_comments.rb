class AddToComments < ActiveRecord::Migration
  def change
  	 add_column :comments, :author_email, :string
  	 add_column :comments, :body, :string
  end
end
