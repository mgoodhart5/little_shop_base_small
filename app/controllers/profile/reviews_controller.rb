class Profile::ReviewsController < ApplicationController
  before_action :require_default_user

  def new
    @review = Review.new
    @order = Order.find(params[:order_id])
    @order_item = OrderItem.find(params[:order_item_id])
    @form_path = [:profile, @order, @order_item, @review]
  end

  def create
    order_item = OrderItem.find(params[:order_item_id])
    item = order_item.item
    user = User.find_by(name: params[:review][:user])
    review = user.reviews.create(review_params)

    order_item.reviews << review

    flash[:notice] = "You left a review for #{item.name}"
    redirect_to item_path(item)
  end

  def disable
    review = Review.find(params[:id])
    order_item = OrderItem.find(review.order_item_id)
    order = Order.find(params[:order_id])
    review.status = false
    review.save

    flash[:notice] = "You disabled your review for #{order_item.item.name}!"
    redirect_to profile_order_path(order)
  end

  def enable
    review = Review.find(params[:id])
    order_item = OrderItem.find(review.order_item_id)
    order = Order.find(params[:order_id])
    review.status = true
    review.save

    flash[:notice] = "You enabled your review for #{order_item.item.name}!"
    redirect_to profile_order_path(order)
  end

  private

  def review_params
    params.require(:review).permit(:title, :rating, :description)
  end

  def require_default_user
    render file: 'errors/not_found', status: 404 unless current_user && current_user.default?
  end

end
