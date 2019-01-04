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

  def disable
    review = Review.find(params[:id])
    user = User.find(review.user_id)
    item = Item.find(review.item_id)
    review.status = false
    review.save

    flash[:notice] = "You disabled your review for #{item.name}!"
    redirect_to profile_path(user)
  end

  private

  def review_params
    params.require(:review).permit(:title, :rating, :description)
  end

end
