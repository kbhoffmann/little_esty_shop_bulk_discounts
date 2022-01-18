require 'rails_helper'

RSpec.describe 'Discounts New Form' do
  it 'has links from the Merchant Discounts Index Page' do
    merchant1 = Merchant.create!(name: 'Cat Stuff')

    visit merchant_discounts_path(merchant1)

    click_link "Create New Discount"

    expect(current_path).to eq(new_merchant_discount_path(merchant1))
  end

  it 'can create a new discount' do
    merchant1 = Merchant.create!(name: 'Cat Stuff')

    visit new_merchant_discount_path(merchant1.id)

    fill_in("Percent Discount", with: 25)
    fill_in("Quantity Threshold", with: 50)

    click_on("Submit")

    expect(current_path).to eq(merchant_discounts_path(merchant1.id))

    visit merchant_discounts_path(merchant1)

    expect(page).to have_content("Percent Discount: 25")
    expect(page).to have_content("Item Quantity Threshold: 50")
  end

  it 'shows an error message if form not filled out with valid information' do
    merchant1 = Merchant.create!(name: 'Cat Stuff')

    visit new_merchant_discount_path(merchant1.id)

    fill_in("Percent Discount", with: -25)
    fill_in("Quantity Threshold", with: -50)

    click_on("Submit")

    expect(current_path).to eq(new_merchant_discount_path(merchant1.id))

    expect(page).to have_content("Discount not Created: Percentage discount must be greater than 0 and Quantity threshold must be greater than 0")
  end
end
