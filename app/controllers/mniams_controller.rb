class MniamsController < ApplicationController
  before_action :set_mniam, only: [:show, :destroy, :edit, :update]

  def index
    @mniams = Mniam.all
  end

  def show
  end

  def destroy
    @mniam.destroy
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
    @mniam = Mniam.new(mniam_params)
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
    params.require(:mniam).permit(:title, :description)
  end
end
