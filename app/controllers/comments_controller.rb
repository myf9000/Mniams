class CommentsController < ApplicationController
 

  def new   
  	 @comment = Comment.new(parent_id: params[:parent_id]) 
     @comment.author = current_user.email
     @comment.user_id = current_user.id
     @comment.mniam_id = @mniam.id
  end

  def create 
    if params[:comment][:parent_id].to_i > 0
      parent = Comment.find_by_id(params[:comment].delete(:parent_id))
      @comment = parent.children.build(comment_params)
      @comment.author = current_user.email
      @comment.user_id = current_user.id
      @comment.mniam_id = @mniam.id
    else
      @mniam = Mniam.friendly.find(params[:mniam_id])
      @comment = @mniam.comments.build(comment_params)
      @comment.author = current_user.email
      @comment.user_id = current_user.id
      @comment.mniam_id = @mniam.id
    end

    if @comment.save
      flash[:success] = 'Your comment was successfully added!'
      redirect_to :back
    else
      render 'new'
    end
  end

private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :mniam_id, :author)
  end
end
