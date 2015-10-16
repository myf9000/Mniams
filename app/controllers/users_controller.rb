class UsersController < ApplicationController
	before_action :search_user, only: [:show, :destroy]
	before_action :authenticate_user!
	def show
	end

	def index 
		@user = User.first
		@users = User.paginate(:page => params[:page], :per_page => 2).order(@user.score(@user))    
	end

	def destroy
	    if current_user.admin? 
	      	if @user.destroy
	      		redirect_to users_path, notice: "User was deleted"
	  		end
	    end
  	end

  	private

  	def search_user
  		@user = User.find(params[:id])
  		@mniams = @user.mniams
  	end
end
