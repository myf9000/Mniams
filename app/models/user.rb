class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :mniams, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tips, dependent: :destroy
  has_attached_file :user_avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://logocache.com/custom-design/logo-name/1533867-designstyle-chess-m.png"
  validates_attachment_content_type :user_avatar, content_type: /\Aimage\/.*\Z/
  
  has_many :favorite_recipes  
  has_many :favorites, through: :favorite_recipes, source: :mniam

  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy

  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :conversations, :foreign_key => :sender_id

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

   def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Mniam.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  def scores(user)
    s = 0
    user.mniams.each do |f|
      s += f.get_upvotes.size
    end
    s 
  end

  def blank_image(f)
    if f.user_avatar.empty?
    end
  end

end
