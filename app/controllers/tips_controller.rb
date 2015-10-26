class TipsController < ApplicationController
  before_action :find_tip, only: [:show, :upvote, :edit, :destroy, :update]
	before_action :authenticate_user!

  def new
  	@tip = current_user.tips.build
  	@tip.user_id = current_user.id
  end

  def create
  	@tip = current_user.tips.build(set_movie)
  	@tip.user_id = current_user.id
    @tip.movie = movie_conventer
    if  @tip.save 
      redirect_to tips_path, notice: "Tip was created"
    else 
      render 'new'
    end
  end

  def show
    @comments = @tip.comments.hash_tree
    @comment = @tip.comments.build(parent_id: params[:parent_id])
    @comment.tip_id = @tip.id
  end

  def index
    @search = Tip.ransack(params[:q])
    @tips = @search.result.order("created_at DESC").paginate(:page => params[:page], :per_page => 7)  
  end

  def top
    @tips = Tip.all
    @tips = @tips.sort {|a, b| b.score<=>a.score}
    @tips = @tips[0..5]
  end

  def edit
    unless @tip.user == current_user  or current_user.admin?
      render 'shared/unprivileged_request'
    end
  end

  def destroy
    if @tip.user == current_user  or current_user.admin?
      @tip.destroy
      @tip.comments.destroy
      redirect_to tips_path, notice: "Tip was deleted"
    else
      render 'shared/unprivileged_request'
    end
  end

  def update
    if @tip.update(set_movie)
      @tip.save
      redirect_to @tip, notice: "Tip was updated"
    else
      render 'edit'
    end
  end

  def movie_conventer
    yt_id = @tip.movie[@tip.movie.length-11...@tip.movie.length]
    if yt_id.nil?
      yt = ""
    else 
      yt = "https://www.youtube.com/embed/" + yt_id
    end
  end

  def upvote 
    @tip.upvote_by current_user
    redirect_to :back, notice: "You like this Tip :)"
  end 

  private

  def set_movie
  	params.require(:tip).permit(:movie, :title, :description, :user_id, :category)
  end

  def find_tip
    @tip = Tip.find(params[:id])
  end
end
