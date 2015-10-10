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

  private 

  def set_mniam
    @mniam = Mniam.find(params[:id])
  end

  def mniam_params
    params.require(:mniam).permit(:title, :description, :avatar, :tag_list)
  end
end
