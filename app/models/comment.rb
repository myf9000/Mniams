class Comment < ActiveRecord::Base
	belongs_to :mniam
	validates :mniam, presence: true
	validates :box, presence: true
end
