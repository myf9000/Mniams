class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :box

      t.timestamps null: false
    end
  end
end
