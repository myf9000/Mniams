class TipsController < ApplicationController
	before_action :authenticate_user!
  def new
  	@tip = current_user.tips.build
  end

  def create
  	@tip = current_user.mniams.build(set_movie)
    if  @tip.save 
      redirect_to @tip, notice: "Tip was created"
    else 
      render 'new'
    end
  end

  def show
  	@tip = Tip.find(params[:id])
  	@tip.movie = movie_conventer
  end

  def index
  	@tips = Tip.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 7)  
  end

  def movie_conventer
    yt_id = @tip.movie[@tip.movie.length-11...@tip.movie.length]
    if yt_id.nil?
      yt = ""
    else 
      yt = "https://www.youtube.com/embed/" + yt_id
    end
  end

  private

  def set_movie
  	params.require(:tip).permit(:movie, :title)
  end
end
