require 'rails_helper'

describe "as a user when I visit an completed order show page" do
  it "sees a button to leave a review next to all fulfilled items" do
    user = create(:user)
    merchant = create(:merchant)
    item_1 = create(:item, user: merchant)
    item_2 = create(:item, user: merchant)
    yesterday = 1.day.ago
    order = create(:completed_order, user: user)
    oi_1 = create(:order_item, order: order, item: item_1, price: 1, quantity: 1, created_at: yesterday, updated_at: yesterday)
    oi_2 = create(:fulfilled_order_item, order: order, item: item_2, price: 2, quantity: 1, created_at: yesterday, updated_at: 2.hours.ago)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit profile_order_path(order)

    within "#oitem-#{oi_1.id}" do
      expect(page).to have_button('Leave Review')
    end

    within "#oitem-#{oi_2.id}" do
      expect(page).to have_button('Leave Review')
    end
  end
  it 'clicks on the button to leave a review and is taken to item/id/review' do
    user = create(:user)
    merchant = create(:merchant)
    item_1 = create(:item, user: merchant)
    yesterday = 1.day.ago
    order = create(:completed_order, user: user)
    oi_1 = create(:order_item, order: order, item: item_1, price: 1, quantity: 1, created_at: yesterday, updated_at: yesterday)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit profile_order_path(order)

    within "#oitem-#{oi_1.id}" do
      click_button('Leave Review')
    end

    expect(current_path).to eq(new_item_review_path(item_1))
  end

  it 'can create a new review with a rating of 1-5' do
    user = create(:user)
    merchant = create(:merchant)
    item_1 = create(:item, user: merchant)
    yesterday = 1.day.ago
    order = create(:completed_order, user: user)
    oi_1 = create(:fulfilled_order_item, order: order, item: item_1, price: 1, quantity: 1, created_at: yesterday, updated_at: yesterday)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit profile_order_path(order)

    within "#oitem-#{oi_1.id}" do
      click_button('Leave Review')
    end

    expect(current_path).to eq(new_item_review_path(item_1))

    review_title = "Didn't need it."
    user_name = "user.name"
    rating = 5
    review_text = "Wasn't useful at all"

    fill_in :review_title, with: review_title
    select("#{rating}", :from => 'review_rating')
    fill_in :review_text, with: review_text
    fill_in :review_user, with: user_name

    click_button 'Create Review'
  end
end
