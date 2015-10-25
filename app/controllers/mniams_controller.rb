class MniamsController < ApplicationController
  before_action :set_mniam, only: [:show, :destroy, :edit, :update, :upvote, :favorite]
  before_action :authenticate_user!, except: [:home]

  def index
    @search = Mniam.ransack(params[:q])
    @mniams = @search.result.order("created_at DESC").paginate(:page => params[:page], :per_page => 7)  
  end

  def show
    @comments = @mniam.comments.hash_tree
    @comment = @mniam.comments.build(parent_id: params[:parent_id])
    @comment.mniam_id = @mniam.id
    @mniams = Mniam.all
    @user = User.find(@mniam.user.id)
    @user.rank = 0
    @user.mniams.each do |f|
      @user.rank += f.get_upvotes.size
    end

     respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "show",:layout => 'pdf.html.erb',:template => '/mniams/show'  # Excluding ".pdf" extension.
      end
    end
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

  def home
    if params[:search]
      @mniams = Mniam.search(params[:search]).order("created_at DESC").paginate(:page => params[:page], :per_page => 14)  
    elsif params[:tag]
      @mniams = Mniam.tagged_with(params[:tag]).order("created_at DESC").paginate(:page => params[:page], :per_page => 14)  
    else
      @mniams = Mniam.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 14)  
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

  def top
    @mniams = Mniam.all
    @mniams = @mniams.sort {|a, b| b.score<=>a.score}
    @top = @mniams[0..4]
  end

  private 

  def set_mniam
    @mniam = Mniam.friendly.find(params[:id])
  end

  def mniam_params
    params.require(:mniam).permit(:title, :description, :avatar, :tag_list, :slug, :price, :difficulty, :typ, :preparation_time,
                                 ingredients_attributes: [:id, :name, :_destroy], directions_attributes: [:id, :step, :_destroy])
  end
end
