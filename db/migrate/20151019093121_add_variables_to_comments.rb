class AddVariablesToComments < ActiveRecord::Migration
  def change
    add_column :comments, :parent_id, :integer
    add_column :comments, :commentable_id, :integer
    add_column :comments, :commentable_type, :string
  end
end
