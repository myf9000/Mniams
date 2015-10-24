class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.string :movie
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :tips, :user_id
  end
end
