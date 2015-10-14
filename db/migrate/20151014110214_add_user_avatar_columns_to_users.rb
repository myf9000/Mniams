class AddUserAvatarColumnsToUsers < ActiveRecord::Migration
  def up
    add_attachment :users, :user_avatar
  end

  def down
    remove_attachment :users, :user_avatar
  end
end
