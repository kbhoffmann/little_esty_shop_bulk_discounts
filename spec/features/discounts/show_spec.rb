require 'rails_helper'

RSpec.describe 'Merchant Discount Show Page' do
  it 'shows the discount quantity and percentagediscount' do
    merchant1 = Merchant.create!(name: 'Cat Stuff')
    discount1 = Discount.create!(percentage_discount: 10, quantity_threshold: 10, merchant_id: merchant1.id)
    discount2 = Discount.create!(percentage_discount: 20, quantity_threshold: 20, merchant_id: merchant1.id)
    discount3 = Discount.create!(percentage_discount: 30, quantity_threshold: 30, merchant_id: merchant1.id)

    visit merchant_discount_path(merchant1, discount1)

    expect(page).to have_content("Percent Discount: #{discount1.percentage_discount}")
    expect(page).to have_content("Item Quantity Threshold: #{discount1.quantity_threshold}")
    expect(page).to_not have_content(discount2.percentage_discount)
    expect(page).to_not have_content(discount2.quantity_threshold)
    expect(page).to_not have_content(discount3.percentage_discount)
    expect(page).to_not have_content(discount3.quantity_threshold)
  end
end
