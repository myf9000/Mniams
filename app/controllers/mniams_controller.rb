class MniamsController < ApplicationController
  before_action :set_mniam, only: [:show, :destroy, :edit, :update]

  def index
  if params[:tag]
    @mniams = Mniam.tagged_with(params[:tag])
  else
    @mniams = Mniam.all
  end
end

  def show
    @comments = @mniam.comments.all.order("created_at DESC")
    @comment = @mniam.comments.build
    @mniam.movie = movie_conventer
  end

  def destroy
    @mniam.destroy
    @mniam.comments.destroy
    redirect_to root_path
  end

  def edit
  end

  def update
    if @mniam.update(mniam_params)
      @mniam.save
      redirect_to @mniam, notice: "Eat was updated"
    else
      render 'edit'
    end
  end

  def create
    @mniam = Mniam.create(mniam_params)
    if  @mniam.save 
      redirect_to @mniam, notice: "Eat was created"
    else 
      render 'new'
    end
  end

  def new
    @mniam = Mniam.new
  end

  def movie_conventer
    yt_id = @mniam.movie[@mniam.movie.length-11...@mniam.movie.length]
    if yt_id.nil?
      yt = ""
    else 
      yt = "https://www.youtube.com/embed/" + yt_id
    end
  end

  private 

  def set_mniam
    @mniam = Mniam.friendly.find(params[:id])
  end

  def mniam_params
    params.require(:mniam).permit(:title, :description, :avatar, :tag_list, :movie, :slug)
  end
end
