class DropyKurwa < ActiveRecord::Migration
   def up
    drop_table :comments
    drop_table :comment_hierarchies
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
