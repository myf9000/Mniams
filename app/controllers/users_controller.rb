class UsersController < ApplicationController
	before_action :search_user, only: [:show, :destroy]
	def show
	end

	def index 
		@users = User.all 
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
  		@user.destroy
  	end
end
