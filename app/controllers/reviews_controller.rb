class ReviewsController < ApplicationController

  def new
    @item = Item.find(params[:id])
    @review = Review.new
  end

  def create
    item = Item.find(params[:id])
    user = User.find_by(name: params[:review][:user])
    review = user.reviews.create(review_params)

    item.reviews << review

    flash[:notice] = "You left a review for #{item.name}"
    redirect_to item_path(item)
  end

  private

  def review_params
    params.require(:review).permit(:title, :rating, :description)
  end

end
