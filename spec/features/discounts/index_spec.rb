require 'rails_helper'

RSpec.describe "Discounts Index Page" do
  before(:each) do
    @merchant1 = Merchant.create!(name: 'Cat Stuff')
    @merchant2 = Merchant.create!(name: 'Dog Stuff')

    @discount1 = Discount.create!(percentage_discount: 10, quantity_threshold: 10, merchant_id: @merchant1.id)
    @discount2 = Discount.create!(percentage_discount: 20, quantity_threshold: 20, merchant_id: @merchant1.id)
    @discount3 = Discount.create!(percentage_discount: 30, quantity_threshold: 30, merchant_id: @merchant1.id)
    @discount4 = Discount.create!(percentage_discount: 50, quantity_threshold: 50, merchant_id: @merchant2.id)

    visit merchant_discounts_path(@merchant1.id)
  end

  it 'has all the bulk discounts with their percentage_discount and quantity_thresholds' do

    expect(page).to have_content("Percent Discount: #{@discount1.percentage_discount}")
    expect(page).to have_content("Item Quantity Threshold: #{@discount1.quantity_threshold}")
    expect(page).to have_content("Percent Discount: #{@discount2.percentage_discount}")
    expect(page).to have_content("Item Quantity Threshold: #{@discount2.quantity_threshold}")
    expect(page).to have_content("Percent Discount: #{@discount3.percentage_discount}")
    expect(page).to have_content("Item Quantity Threshold: #{@discount3.quantity_threshold}")
    expect(page).to_not have_content(@discount4.percentage_discount)
    expect(page).to_not have_content(@discount4.quantity_threshold)
  end

  it 'has a link to each discounts show page' do
    within ("#discount-#{@discount1.id}") do
      has_link? "View Discount"
    end

    within ("#discount-#{@discount2.id}") do
      has_link? "View Discount"
    end

    within ("#discount-#{@discount3.id}") do
      has_link? "View Discount"
    end

    within ("#discount-#{@discount1.id}") do
      click_link "View Discount"
      expect(current_path).to eq(merchant_discount_path(@merchant1, @discount1))
      expect(current_path).to_not eq(merchant_discount_path(@merchant1, @discount2))
      expect(current_path).to_not eq(merchant_discount_path(@merchant1, @discount3))
    end
  end

  it 'has a section with an Upcoming Holidays header' do
    expect(page).to have_content("Upcoming Holidays")
  end

  it 'has a link to create a new discount' do
    click_link "Create New Discount"
    expect(current_path).to eq(new_merchant_discount_path(@merchant1))
    expect(current_path).to_not eq(new_merchant_discount_path(@merchant2))
  end

  it 'has a link to delete a discount' do
    within ("#discount-#{@discount1.id}") do
      has_link? "Delete Discount"
    end

    within ("#discount-#{@discount2.id}") do
      has_link? "Delete Discount"
    end

    within ("#discount-#{@discount3.id}") do
      has_link? "Delete Discount"
    end

    within ("#discount-#{@discount1.id}") do
      click_link "Delete Discount"
      expect(current_path).to eq(merchant_discounts_path(@merchant1.id))
      expect(current_path).to_not eq(merchant_discounts_path(@merchant2.id))
    end

    visit merchant_discounts_path(@merchant1.id)

    expect(page).to_not have_content(@discount1.percentage_discount)
    expect(page).to_not have_content(@discount1.quantity_threshold)
    expect(page).to have_content("Percent Discount: #{@discount2.percentage_discount}")
    expect(page).to have_content("Item Quantity Threshold: #{@discount2.quantity_threshold}")
    expect(page).to have_content("Percent Discount: #{@discount3.percentage_discount}")
    expect(page).to have_content("Item Quantity Threshold: #{@discount3.quantity_threshold}")
  end
end
