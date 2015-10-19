class AddSluqToComments < ActiveRecord::Migration
  def change
    add_column :comments, :sluq, :string
    add_index :comments, :sluq, unique: true
  end
end
