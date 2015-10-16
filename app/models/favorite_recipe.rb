class FavoriteRecipe < ActiveRecord::Base
	belongs_to :mniam
  	belongs_to :user
end
