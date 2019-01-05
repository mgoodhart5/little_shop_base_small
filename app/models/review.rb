class Review < ApplicationRecord
  validates_presence_of :title, :description, :rating

  belongs_to :order_item
  belongs_to :user

  def user_name
    user.name
  end

end
