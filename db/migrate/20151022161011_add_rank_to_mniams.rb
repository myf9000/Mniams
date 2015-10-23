class AddRankToMniams < ActiveRecord::Migration
  def change
    add_column :mniams, :rank, :integer
  end
end
