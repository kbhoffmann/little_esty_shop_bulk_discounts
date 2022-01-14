require 'rails_helper'

RSpec.describe "Discounts Index Page" do
  before(:each) do
    @merchant1 = Merchant.create!(name: 'Cat Stuff')
    @discountA = @merchant1.discounts.create!(percentage_discount: 10, quantity_threshold: 10)
    @discountB = @merchant1.discounts.create!(percentage_discount: 20, quantity_threshold: 20)
    @discountC = @merchant1.discounts.create!(percentage_discount: 30, quantity_threshold: 30)

    visit "/merchant/#{@merchant1.id}/discounts"
  end

  xit 'has all the bulk discounts with their percentage_discount and quantity_thresholds' do
    # Where I see all of my bulk discounts including their
    # percentage discount and quantity thresholds
    expect(page).to have_content(@discountA.percentage_discount)
    expect(page).to have_content(@discountA.quantity_threshold)
    expect(page).to have_content(@discountB.percentage_discount)
    expect(page).to have_content(@discountB.quantity_threshold)
    expect(page).to have_content(@discountC.percentage_discount)
    expect(page).to have_content(@discountC.quantity_threshold)
  end

  xit 'has a link to each discounts show page' do
    # And each bulk discount listed includes a link to its show page
    within ("#discount-#{discountA.id}") do
      expect(page).to have_link("View Discount")
      click_link "View Discount"
      expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts/#{@discountA.id}")
    end

    within ("#discount-#{discountB.id}") do
      expect(page).to have_link("View Discount")
      click_link "View Discount"
      expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts/#{@discountB.id}")
    end
  end
end
