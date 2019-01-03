class ReviewsController < ApplicationController

  def new
    @item = Item.find(params[:id])
    @review = Review.new
  end

  def create
    item = Item.find(params[:id])
  end

end
