class Tip < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy

	validates :title, presence: true, length: { maximum: 70 }
	validates :description, presence: true, length: { maximum: 400 }
	validates :movie, presence: true

	acts_as_votable

	def score
      self.get_upvotes.size 
   	end
end
