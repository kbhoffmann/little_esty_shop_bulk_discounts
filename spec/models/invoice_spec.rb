require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many :transactions}
  end
  describe "instance methods" do
    # it "total_revenue" do
    #   merchant1 = Merchant.create!(name: 'Hair Care')
    #   item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: merchant1.id, status: 1)
    #   item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: merchant1.id)
    #   customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
    #   invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
    #   ii_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 9, unit_price: 10, status: 2)
    #   ii_11 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_8.id, quantity: 1, unit_price: 10, status: 1)
    #
    #   expect(@invoice_1.total_revenue).to eq(100)
    # end
  end

  describe 'Bulk Discounts Revenue' do
    it 'discounts a single item that meets the quantity threshold' do
      merchant1 = Merchant.create!(name: 'Hair Care')
      customer1 = Customer.create!(first_name: 'Brooke', last_name: 'Stewart')

      invoice1 = Invoice.create!(customer_id: customer1.id, status: 2)
      invoice2 = Invoice.create!(customer_id: customer1.id, status: 2)
      invoice3 = Invoice.create!(customer_id: customer1.id, status: 2)

      transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice1.id)
      transaction2 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice2.id)
      transaction3 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice2.id)

      item1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: merchant1.id, status: 1)
      item2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: merchant1.id, status: 1)
      item3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: merchant1.id, status: 1)

      ii1 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 5, unit_price: 10, status: 2)
      ii2 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item2.id, quantity: 10, unit_price: 8, status: 2)
      ii3 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item3.id, quantity: 30, unit_price: 5, status: 2)

      ii4 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item1.id, quantity: 5, unit_price: 10, status: 2)
      ii5 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item2.id, quantity: 10, unit_price: 8, status: 2)
      ii6 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item3.id, quantity: 20, unit_price: 5, status: 2)

      ii7 = InvoiceItem.create!(invoice_id: invoice3.id, item_id: item1.id, quantity: 5, unit_price: 10, status: 2)
      ii8 = InvoiceItem.create!(invoice_id: invoice3.id, item_id: item2.id, quantity: 10, unit_price: 8, status: 2)
      ii9 = InvoiceItem.create!(invoice_id: invoice3.id, item_id: item3.id, quantity: 10, unit_price: 5, status: 2)

      discount1 = Discount.create!(percentage_discount: 10, quantity_threshold: 10, merchant_id: merchant1.id)
      discount2 = Discount.create!(percentage_discount: 20, quantity_threshold: 20, merchant_id: merchant1.id)
      discount3 = Discount.create!(percentage_discount: 30, quantity_threshold: 30, merchant_id: merchant1.id)

      expect(invoice1.max_percent_discount).to eq(30)
      expect(invoice2.max_percent_discount).to eq(20)
      expect(invoice3.max_percent_discount).to eq(10)
    end
  end
end

# expect(invoice1.revenue_after_discount).to eq(235)
#break down problem and find max percentage_discount
