class DropBlabla < ActiveRecord::Migration
   def up
    drop_table :add_to_comments
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
