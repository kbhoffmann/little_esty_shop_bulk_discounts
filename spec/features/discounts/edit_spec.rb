require 'rails_helper'

RSpec.describe 'Merchant Discount Edit Page' do
  before (:each) do
    @merchant1 = Merchant.create!(name: 'Cat Stuff')
    @discount1 = Discount.create!(percentage_discount: 10, quantity_threshold: 20, merchant_id: @merchant1.id)
    @discount2 = Discount.create!(percentage_discount: 5, quantity_threshold: 15, merchant_id: @merchant1.id)

    visit edit_merchant_discount_path(@merchant1.id, @discount1.id)
  end

  it 'has a prepopulated form for editing a discount' do

    expect(page).to have_field("Percent Discount", with: 10)
    expect(page).to have_field("Quantity Threshold", with: 20)
    expect(page).to_not have_field("Percent Discount", with: 5)
    expect(page).to_not have_field("Quantity Threshold", with: 15)
  end

  it 'can edit both discount attributes' do

    fill_in("Percent Discount", with: 25)
    fill_in("Quantity Threshold", with: 50)

    click_on "Submit"

    expect(current_path).to eq(merchant_discount_path(@merchant1, @discount1))

    visit merchant_discount_path(@merchant1, @discount1)

    expect(page).to have_content("Percent Discount: 25")
    expect(page).to have_content("Item Quantity Threshold: 50")
    expect(page).to_not have_content("Percent Discount: 10")
    expect(page).to_not have_content("Item Quantity Threshold: 20")
  end

  it 'can update only the percent discount' do

    fill_in("Percent Discount", with: 25)

    click_on "Submit"

    expect(current_path).to eq(merchant_discount_path(@merchant1, @discount1))

    visit merchant_discount_path(@merchant1, @discount1)

    expect(page).to have_content("Percent Discount: 25")
    expect(page).to have_content("Item Quantity Threshold: 20")
    expect(page).to_not have_content("Percent Discount: 10")

  end

  it 'can update only the quantity threshold' do

    fill_in("Quantity Threshold", with: 50)

    click_on "Submit"

    expect(current_path).to eq(merchant_discount_path(@merchant1, @discount1))

    visit merchant_discount_path(@merchant1, @discount1)

    expect(page).to have_content("Percent Discount: 10")
    expect(page).to have_content("Item Quantity Threshold: 50")
    expect(page).to_not have_content("Item Quantity Threshold: 20")
  end
end
