class CommentsController < ApplicationController
  def create
		@mniam = Mniam.friendly.find(params[:mniam_id])
		@comment = @mniam.comments.create(comments_params)
		@comment.author_email = current_user.email
		if @comment.save
			redirect_to :back, notice: "Comment was added..."
		else 
			redirect_to :back, notice: "Comment wasn't added..."
		end
	end

	private

	def comments_params
		params.require(:comment).permit(:body)    
	end
end
