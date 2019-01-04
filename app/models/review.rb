class Review < ApplicationRecord
  validates_presence_of :title, :description, :rating

  belongs_to :item
  belongs_to :user

  def user_name
    user = User.find(self.user_id)
    user.name
  end


end
