class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@mniams = @user.mniams
	end

	def index 
		@users = User.all 
	end
end
