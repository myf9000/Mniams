class Mniam < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  	acts_as_taggable_on :content, :name, :tag_list
	acts_as_taggable
	validates :title, :description, :avatar, presence: true

	extend FriendlyId
  	friendly_id :title, use: :slugged

  	has_many :ingredients
  	has_many :directions

  	accepts_nested_attributes_for :ingredients,
								  	reject_if: proc { |attributes| attributes['name'].blank? },
								  	allow_destroy: true
 	
 	accepts_nested_attributes_for :directions,
								 	reject_if: proc { |attributes| attributes['step'].blank? },
								  	allow_destroy: true
end
