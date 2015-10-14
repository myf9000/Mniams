class MniamsController < ApplicationController
  before_action :set_mniam, only: [:show, :destroy, :edit, :update, :upvote]
  before_action :authenticate_user!, except: [:show, :home]

  def index
    @search = Mniam.search(params[:q])
    @mniams = @search.result
  end

  def show
    @comments = @mniam.comments.all.order("created_at DESC")
    @comment = @mniam.comments.build
    @mniam.movie = movie_conventer
  end

  def destroy
    if @mniam.user != current_user
      render 'unprivileged_request'
    else
      @mniam.destroy
      @mniam.comments.destroy
      redirect_to root_path, notice: "Eat was deleted"
    end
  end

  def edit
    if @mniam.user != current_user
      render 'unprivileged_request'
    end
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
    @mniam = current_user.mniams.build(mniam_params)
    if  @mniam.save 
      redirect_to @mniam, notice: "Eat was created"
    else 
      render 'new'
    end
  end

  def new
    @mniam = current_user.mniams.build
  end

  def movie_conventer
    yt_id = @mniam.movie[@mniam.movie.length-11...@mniam.movie.length]
    if yt_id.nil?
      yt = ""
    else 
      yt = "https://www.youtube.com/embed/" + yt_id
    end
  end

  def home
    if params[:tag]
      @mniams = Mniam.tagged_with(params[:tag])
    else
      @mniams = Mniam.all
    end
  end

  def upvote 
    @mniam.upvote_by current_user
    redirect_to :back
  end  

  private 

  def set_mniam
    @mniam = Mniam.friendly.find(params[:id])
  end

  def mniam_params
    params.require(:mniam).permit(:title, :description, :avatar, :tag_list, :movie, :slug, :price, :difficulty, :typ, :preparation_time,
                                 ingredients_attributes: [:id, :name, :_destroy], directions_attributes: [:id, :step, :_destroy])
  end
end
