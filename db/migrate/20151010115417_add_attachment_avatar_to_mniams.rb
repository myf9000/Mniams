class AddAttachmentAvatarToMniams < ActiveRecord::Migration
  def self.up
    change_table :mniams do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :mniams, :avatar
  end
end
