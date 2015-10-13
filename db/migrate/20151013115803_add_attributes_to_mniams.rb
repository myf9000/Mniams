class AddAttributesToMniams < ActiveRecord::Migration
  def change
    add_column :mniams, :price, :integer
    add_column :mniams, :difficulty, :string
    add_column :mniams, :preparation_time, :integer
  end
end
