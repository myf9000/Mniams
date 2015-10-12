class AddSlugToMniams < ActiveRecord::Migration
  def change
    add_column :mniams, :slug, :string
    add_index :mniams, :slug, unique: true
  end
end
