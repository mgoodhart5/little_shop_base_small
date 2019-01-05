class Review < ApplicationRecord
  validates_presence_of :title, :description, :rating

  belongs_to :order_item
  belongs_to :user

  def user_name
    user.name
  end

  def self.enabled_reviews(item)
    where(status:true, order_item: item.order_items)
  end

end
