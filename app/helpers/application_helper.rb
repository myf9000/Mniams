module ApplicationHelper
	def set_title_of_page(page_title="")
		add = "Recipes"
		if page_title.empty?
			page_title = add
		else
			page_title = page_title+ " | " +add
		end
	end

	def current_user?(user)
    	user == current_user
  	end

  	def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
