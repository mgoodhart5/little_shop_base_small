class AddOrderItemsToReviews < ActiveRecord::Migration[5.1]
  def change
    add_reference :reviews, :order_item, foreign_key: true
  end
end
