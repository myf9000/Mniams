class Contact < MailForm::Base
	attribute :name, 		:validate => true
	attribute :email, 		:validate => /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
	attribute :message,		:validate => true
	attribute :nickname,	:captcha  => true


	def headers 
		{
			:subject => "Contact Form",
			:to => "ja180@vp.pl",
			:from => %("#{name}" <#{email}>)
		}
	end
end