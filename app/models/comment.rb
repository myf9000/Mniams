class Comment < ActiveRecord::Base
	#attr_accessible :title, :body, :author
	acts_as_tree order: 'created_at DESC'
	belongs_to :user
	belongs_to :mniam
	belongs_to :tips
end
