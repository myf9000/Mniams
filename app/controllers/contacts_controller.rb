class ContactsController < ApplicationController
	def new
		@contact = Contact.new
	end

	def create	
		@contact = Contact.new(params[:contact])
		@contact.request = request
		if verify_recaptcha(:contact => @contact) && @contact.deliver
			flash.now[:success]= "You send message"
		else 
			flash.now[:error]= "Cannot send message"
			render :new
		end
	end
end
