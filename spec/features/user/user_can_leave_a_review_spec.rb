require 'rails_helper'

describe "as a user when I visit an completed order show page" do
  before(:each) do
    @user = create(:user)
    @merchant = create(:merchant)
    @item_1 = create(:item, user: @merchant)
    @item_2 = create(:item, user: @merchant)
    @@yesterday = 1.day.ago
    @order = create(:completed_order, user: @user)
    @oi_1 = create(:fulfilled_order_item, order: @order, item: @item_1, price: 1, quantity: 1, created_at: @yesterday, updated_at: @yesterday)
    @oi_2 = create(:fulfilled_order_item, order: @order, item: @item_2, price: 2, quantity: 1, created_at: @yesterday, updated_at: 2.hours.ago)
  end
  it "sees a button to leave a review next to all fulfilled items" do

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit profile_order_path(@order)

    within "#oitem-#{@oi_1.id}" do
      expect(page).to have_button('Leave Review')
    end

    within "#oitem-#{@oi_2.id}" do
      expect(page).to have_button('Leave Review')
    end
  end
  it 'clicks on the button to leave a review and is taken to item/id/review' do

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit profile_order_path(@order)

    within "#oitem-#{@oi_1.id}" do
      click_button('Leave Review')
    end

    expect(current_path).to eq(new_item_reviews_path(@item_1))

    expect(page).to have_content("Leave a Review!")
  end

  it 'can create a new review with a rating of 1-5' do

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit profile_order_path(@order)

    within "#oitem-#{@oi_1.id}" do
      click_button('Leave Review')
    end

    expect(current_path).to eq(new_item_reviews_path(@item_1))

    review_title = "Didn't need it."
    user_name = "#{@user.name}"
    rating = 5
    review_text = "Wasn't useful at all"

    fill_in :review_title, with: review_title
    fill_in :review_user, with: user_name
    select("#{rating}", :from => 'review_rating')
    fill_in :review_description, with: review_text
    click_button 'Create Review'

    expect(current_path).to eq(item_path(@item_1))

    within "#review-0" do
      expect(page).to have_content(user_name)
      expect(page).to have_content(review_text)
      expect(page).to have_content("Rating: #{rating}")
      expect(page).to have_content(review_title)
      expect(page).to have_link("Return to Profile")
    end
    expect(page).to have_content("You left a review for #{@item_1.name}")
  end
  it 'cannot leave another review on that same item for that order' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit profile_order_path(@order)

    within "#oitem-#{@oi_1.id}" do
      click_button('Leave Review')
    end

    expect(current_path).to eq(new_item_reviews_path(@item_1))

    review_title = "Didn't need it."
    user_name = "#{@user.name}"
    rating = 5
    review_text = "Wasn't useful at all"

    fill_in :review_title, with: review_title
    fill_in :review_user, with: user_name
    select("#{rating}", :from => 'review_rating')
    fill_in :review_description, with: review_text
    click_button 'Create Review'

    visit profile_order_path(@order)

    within "#oitem-#{@oi_1.id}" do
      expect(page).to_not have_button('Leave Review')
    end

    within "#oitem-#{@oi_2.id}" do
      expect(page).to have_button('Leave Review')
    end

    expect(current_path).to eq(profile_order_path(@order))
  end
end
