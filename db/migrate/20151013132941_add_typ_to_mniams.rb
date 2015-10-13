class AddTypToMniams < ActiveRecord::Migration
  def change
    add_column :mniams, :typ, :string
  end
end
