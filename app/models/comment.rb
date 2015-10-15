class Comment < ActiveRecord::Base
	belongs_to :mniam	
	belongs_to :user	
	validates :mniam, presence: true		
 	validates :body, presence: true
end
