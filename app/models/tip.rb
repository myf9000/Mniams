class Tip < ActiveRecord::Base
	belongs_to :user
	has_many :comments

	validates :movie, presence: true
end
