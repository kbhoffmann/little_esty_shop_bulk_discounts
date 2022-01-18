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
    it "total_revenue" do
      merchant1 = Merchant.create!(name: 'Hair Care')
      item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: merchant1.id, status: 1)
      item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: merchant1.id)
      customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      ii_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 9, unit_price: 10, status: 2)
      ii_11 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_8.id, quantity: 1, unit_price: 10, status: 1)

      expect(invoice_1.total_revenue).to eq(100)
    end
  end

  describe 'Bulk Discounts Revenue' do
    it 'finds total revenue after discounts applied' do
      merchantA = Merchant.create!(name: 'Hair Care')
      merchantB = Merchant.create!(name: 'Pet Stuff')
      customer1 = Customer.create!(first_name: 'Brooke', last_name: 'Stewart')
      invoiceA = Invoice.create!(customer_id: customer1.id, status: 2)
      transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoiceA.id)
      itemA = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: merchantA.id, status: 1)
      itemB = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: merchantA.id, status: 1)
      itemC = Item.create!(name: "Dog Food", description: "Food for the Dog", unit_price: 25, merchant_id: merchantB.id, status: 1)

      iiA = InvoiceItem.create!(invoice_id: invoiceA.id, item_id: itemA.id, quantity: 12, unit_price: 10, status: 2)
      iiB = InvoiceItem.create!(invoice_id: invoiceA.id, item_id: itemB.id, quantity: 15, unit_price: 8, status: 2)
      iiC = InvoiceItem.create!(invoice_id: invoiceA.id, item_id: itemC.id, quantity: 15, unit_price: 25, status: 2)

      discountA = Discount.create!(percentage_discount: 20, quantity_threshold: 10, merchant_id: merchantA.id)
      discountB = Discount.create!(percentage_discount: 30, quantity_threshold: 15, merchant_id: merchantA.id)

      expect(invoiceA.total_revenue).to eq(615)
      expect(invoiceA.revenue_after_discount).to eq(555)

      invoiceB = Invoice.create!(customer_id: customer1.id, status: 2)

      iiD = InvoiceItem.create!(invoice_id: invoiceB.id, item_id: itemA.id, quantity: 12, unit_price: 10, status: 2)
      iiE = InvoiceItem.create!(invoice_id: invoiceB.id, item_id: itemB.id, quantity: 15, unit_price: 8, status: 2)
      iiF = InvoiceItem.create!(invoice_id: invoiceB.id, item_id: itemC.id, quantity: 15, unit_price: 25, status: 2)

      discountA = Discount.create!(percentage_discount: 20, quantity_threshold: 10, merchant_id: merchantA.id)
      discountB = Discount.create!(percentage_discount: 30, quantity_threshold: 15, merchant_id: merchantA.id)
      discountC = Discount.create!(percentage_discount: 30, quantity_threshold: 15, merchant_id: merchantB.id)

      expect(invoiceB.total_revenue).to eq(615)
      expect(invoiceB.revenue_after_discount).to eq(442.50)
    end
  end
end
