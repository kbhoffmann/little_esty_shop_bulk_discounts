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

    expect(page).to have_content("Percent Discount: #{@discount1.percentage_discount}")
    expect(page).to have_content("Item Quantity Threshold: #{@discount1.quantity_threshold}")
    expect(page).to have_content("Percent Discount: #{@discount2.percentage_discount}")
    expect(page).to have_content("Item Quantity Threshold: #{@discount2.quantity_threshold}")
    expect(page).to have_content("Percent Discount: #{@discount3.percentage_discount}")
    expect(page).to have_content("Item Quantity Threshold: #{@discount3.quantity_threshold}")
  end

  it 'has a link to each discounts show page' do
    within ("#discount-#{@discount1.id}") do
      expect(page).to have_link("View Discount")
      have_link "View Discount"
    end

    within ("#discount-#{@discount2.id}") do
      expect(page).to have_link("View Discount")
      have_link "View Discount"
    end

    within ("#discount-#{@discount3.id}") do
      expect(page).to have_link("View Discount")
      have_link "View Discount"
    end

    within ("#discount-#{@discount1.id}") do
      click_link "View Discount"
      expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts/#{@discount1.id}")
    end
  end

  it 'has a section with an Upcoming Holidays header' do
    expect(page).to have_content("Upcoming Holidays")
  end
end
