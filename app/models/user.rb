class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :mniams, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_attached_file :user_avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :user_avatar, content_type: /\Aimage\/.*\Z/

  has_many :favorite_recipes  
  has_many :favorites, through: :favorite_recipes, source: :mniam

  def score(user)
    mniams = Mniam.all
    rank = 0
    user.mniams.each do |f|
	     rank += f.get_upvotes.size
	  end
    return rank
  end

end
