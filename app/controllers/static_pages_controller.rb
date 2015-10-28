class StaticPagesController < ApplicationController
  def News
  end

  def About
  	render :layout=> "layout_for_about"
  end

  def Contact
  end
end
