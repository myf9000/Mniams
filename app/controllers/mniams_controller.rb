class MniamsController < ApplicationController
  before_action :set_mniam, only: [:show, :destroy, :edit, :update, :upvote, :favorite]
  before_action :authenticate_user!, except: [:show, :home]

  def index
    @search = Mniam.search(params[:q])
    @mniams = @search.result
  end

  def show
    @comments = @mniam.comments.all.order("created_at DESC")    
    @comment = @mniam.comments.build
    @mniams = Mniam.all
    @rank = 0
    @user = User.find(@mniam.user.id)
    @user.mniams.each do |f|
      @rank += f.get_upvotes.size
    end
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
    redirect_to :back, notice: "You like this Mniams :)"
  end  

   def favorite
    type = params[:type]
    if type == "favorite"
        current_user.favorites << @mniam
        redirect_to :back, notice: 'You favorited this mniams'
    elsif type == "unfavorite"
      current_user.favorites.delete(@mniam)
      redirect_to :back, notice: 'Unfavorited this mnians'
    else
      redirect_to :back, notice: 'Nothing happened.'
    end
  end

  def favorite_list
    @mniams = current_user.favorites
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
