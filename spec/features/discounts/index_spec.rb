require 'rails_helper'

RSpec.describe "Discounts Index Page" do
  before(:each) do
    @merchant1 = Merchant.create!(name: 'Cat Stuff')

    @discount1 = Discount.create!(percentage_discount: 10, quantity_threshold: 10, merchant_id: @merchant1.id)
    @discount2 = Discount.create!(percentage_discount: 20, quantity_threshold: 20, merchant_id: @merchant1.id)
    @discount3 = Discount.create!(percentage_discount: 30, quantity_threshold: 30, merchant_id: @merchant1.id)

    visit "/merchant/#{@merchant1.id}/discounts"
  end

  it 'has all the bulk discounts with their percentage_discount and quantity_thresholds' do
    # Where I see all of my bulk discounts including their
    # percentage discount and quantity thresholds
    expect(page).to have_content(@discount1.percentage_discount)
    expect(page).to have_content(@discount1.quantity_threshold)
    expect(page).to have_content(@discount2.percentage_discount)
    expect(page).to have_content(@discount2.quantity_threshold)
    expect(page).to have_content(@discount3.percentage_discount)
    expect(page).to have_content(@discount3.quantity_threshold)
  end

  xit 'has a link to each discounts show page' do
    # And each bulk discount listed includes a link to its show page
    within ("#discount-#{discountA.id}") do
      expect(page).to have_link("View Discount")
      click_link "View Discount"
      expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts/#{@discount1.id}")
    end

    within ("#discount-#{discountB.id}") do
      expect(page).to have_link("View Discount")
      click_link "View Discount"
      expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts/#{@discount2.id}")
    end
  end
end
