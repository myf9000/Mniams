class CommentsController < ApplicationController
	def create
		@mniam = Mniam.friendly.find(params[:mniam_id])
		@comment = @mniam.comments.create(comment_params)
		if @comment.save
			redirect_to :back, notice: "Comment was added..."
		else 
			redirect_to :back, notice: "Comment wasn't added..."
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:box)
	end
end
