class Mniam < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  	acts_as_taggable_on :content, :name, :tag_list
	acts_as_taggable
	acts_as_votable

	VALID_REGEX = /[a-zA-Z0-9\s]/
	
	validates :title,  presence: true, length: { maximum: 50 }, format: { with: VALID_REGEX }
	validates :description,  presence: true, length: { maximum: 255 }, format: { with: VALID_REGEX }
	validates :price, length: { maximum: 3 }, :numericality => true, :allow_blank => true
	validates :preparation_time, length: { maximum: 3 }, :numericality => true, :allow_blank => true
	validates :difficulty, :typ, presence: true
	
	extend FriendlyId
  	friendly_id :title, use: :slugged

  	has_many :ingredients
  	has_many :directions

  	has_many :favorite_recipes  
    has_many :favorited_by, through: :favorite_recipes, source: :mniam 

  	accepts_nested_attributes_for :ingredients,
								  	reject_if: proc { |attributes| attributes['name'].blank? },
								  	allow_destroy: true
 	
 	accepts_nested_attributes_for :directions,
								 	reject_if: proc { |attributes| attributes['step'].blank? },
								  	allow_destroy: true

	def related(mniam)
		mniams = Mniam.all.select {|i| i.typ == mniam.typ and i.id != mniam.id}
	end

	

	def score(mniam)
    	mniam.get_upvotes.size
  	end

  	def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    where("title like ?", "%#{query}%") 
  end

end
