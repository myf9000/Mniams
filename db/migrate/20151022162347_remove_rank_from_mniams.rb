class RemoveRankFromMniams < ActiveRecord::Migration
  def change
    remove_column :mniams, :rank, :integer
  end
end
