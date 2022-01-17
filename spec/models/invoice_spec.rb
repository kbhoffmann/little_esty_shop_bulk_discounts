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
    it 'finds the max percentage discount by quantity' do
      merchant1 = Merchant.create!(name: 'Hair Care')
      customer1 = Customer.create!(first_name: 'Brooke', last_name: 'Stewart')

      invoice1 = Invoice.create!(customer_id: customer1.id, status: 2)
      invoice2 = Invoice.create!(customer_id: customer1.id, status: 2)
      invoice3 = Invoice.create!(customer_id: customer1.id, status: 2)
      invoice4 = Invoice.create!(customer_id: customer1.id, status: 2)

      transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice1.id)
      transaction2 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice2.id)
      transaction3 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice2.id)
      transaction4 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice2.id)

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

      ii10 = InvoiceItem.create!(invoice_id: invoice4.id, item_id: item1.id, quantity: 5, unit_price: 10, status: 2)
      ii11 = InvoiceItem.create!(invoice_id: invoice4.id, item_id: item2.id, quantity: 5, unit_price: 8, status: 2)
      ii12 = InvoiceItem.create!(invoice_id: invoice4.id, item_id: item3.id, quantity: 5, unit_price: 5, status: 2)

      discount1 = Discount.create!(percentage_discount: 10, quantity_threshold: 10, merchant_id: merchant1.id)
      discount2 = Discount.create!(percentage_discount: 20, quantity_threshold: 20, merchant_id: merchant1.id)
      discount3 = Discount.create!(percentage_discount: 30, quantity_threshold: 30, merchant_id: merchant1.id)

      expect(invoice1.max_percent_discount).to eq(30)
      expect(invoice2.max_percent_discount).to eq(20)
      expect(invoice3.max_percent_discount).to eq(10)
      expect(invoice4.max_percent_discount).to eq(nil)
    end

    it 'finds revenue that is discountable' do
      merchant1 = Merchant.create!(name: 'Hair Care')
      customer1 = Customer.create!(first_name: 'Brooke', last_name: 'Stewart')

      invoice1 = Invoice.create!(customer_id: customer1.id, status: 2)
      invoice2 = Invoice.create!(customer_id: customer1.id, status: 2)
      invoice3 = Invoice.create!(customer_id: customer1.id, status: 2)
      invoice4 = Invoice.create!(customer_id: customer1.id, status: 2)

      transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice1.id)
      transaction2 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice2.id)
      transaction3 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice2.id)
      transaction4 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice2.id)

      item1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: merchant1.id, status: 1)
      item2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: merchant1.id, status: 1)
      item3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: merchant1.id, status: 1)
      #All items eligible for bulk discount
      ii1 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 10, unit_price: 10, status: 2)
      ii2 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item2.id, quantity: 10, unit_price: 8, status: 2)
      ii3 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item3.id, quantity: 10, unit_price: 5, status: 2)
      #2 items elibigle for bulk discount
      ii4 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item1.id, quantity: 10, unit_price: 10, status: 2)
      ii5 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item2.id, quantity: 10, unit_price: 8, status: 2)
      ii6 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item3.id, quantity: 5, unit_price: 5, status: 2)
      #1 item eligible for bulk discount
      ii7 = InvoiceItem.create!(invoice_id: invoice3.id, item_id: item1.id, quantity: 10, unit_price: 10, status: 2)
      ii8 = InvoiceItem.create!(invoice_id: invoice3.id, item_id: item2.id, quantity: 5, unit_price: 8, status: 2)
      ii9 = InvoiceItem.create!(invoice_id: invoice3.id, item_id: item3.id, quantity: 5, unit_price: 5, status: 2)
      #no items elibigle for bulk discount == even need this?????? May be accounted for in max percentage discount
      ii10 = InvoiceItem.create!(invoice_id: invoice4.id, item_id: item1.id, quantity: 5, unit_price: 10, status: 2)
      ii11 = InvoiceItem.create!(invoice_id: invoice4.id, item_id: item2.id, quantity: 5, unit_price: 8, status: 2)
      ii12 = InvoiceItem.create!(invoice_id: invoice4.id, item_id: item3.id, quantity: 5, unit_price: 5, status: 2)

      discount1 = Discount.create!(percentage_discount: 10, quantity_threshold: 10, merchant_id: merchant1.id)

      expect(invoice1.discountable_revenue).to eq(230)
      expect(invoice2.discountable_revenue).to eq(180)
      expect(invoice3.discountable_revenue).to eq(100)
      expect(invoice4.discountable_revenue).to eq(0)
    end

    it 'finds revenue that is NOT discountable' do
      merchant1 = Merchant.create!(name: 'Hair Care')
      customer1 = Customer.create!(first_name: 'Brooke', last_name: 'Stewart')

      invoice1 = Invoice.create!(customer_id: customer1.id, status: 2)
      invoice2 = Invoice.create!(customer_id: customer1.id, status: 2)
      invoice3 = Invoice.create!(customer_id: customer1.id, status: 2)
      invoice4 = Invoice.create!(customer_id: customer1.id, status: 2)

      transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice1.id)
      transaction2 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice2.id)
      transaction3 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice2.id)
      transaction4 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice2.id)

      item1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: merchant1.id, status: 1)
      item2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: merchant1.id, status: 1)
      item3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: merchant1.id, status: 1)
      #All items eligible for bulk discount
      ii1 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 10, unit_price: 10, status: 2)
      ii2 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item2.id, quantity: 10, unit_price: 8, status: 2)
      ii3 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item3.id, quantity: 10, unit_price: 5, status: 2)
      #2 items elibigle for bulk discount
      ii4 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item1.id, quantity: 10, unit_price: 10, status: 2)
      ii5 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item2.id, quantity: 10, unit_price: 8, status: 2)
      ii6 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item3.id, quantity: 5, unit_price: 5, status: 2)
      #1 item eligible for bulk discount
      ii7 = InvoiceItem.create!(invoice_id: invoice3.id, item_id: item1.id, quantity: 10, unit_price: 10, status: 2)
      ii8 = InvoiceItem.create!(invoice_id: invoice3.id, item_id: item2.id, quantity: 5, unit_price: 8, status: 2)
      ii9 = InvoiceItem.create!(invoice_id: invoice3.id, item_id: item3.id, quantity: 5, unit_price: 5, status: 2)
      #no items elibigle for bulk discount == even need this?????? May be accounted for in max percentage discount
      ii10 = InvoiceItem.create!(invoice_id: invoice4.id, item_id: item1.id, quantity: 5, unit_price: 10, status: 2)
      ii11 = InvoiceItem.create!(invoice_id: invoice4.id, item_id: item2.id, quantity: 5, unit_price: 8, status: 2)
      ii12 = InvoiceItem.create!(invoice_id: invoice4.id, item_id: item3.id, quantity: 5, unit_price: 5, status: 2)

      discount1 = Discount.create!(percentage_discount: 10, quantity_threshold: 10, merchant_id: merchant1.id)

      expect(invoice1.non_discountable_revenue).to eq(0)
      expect(invoice2.non_discountable_revenue).to eq(25)
      expect(invoice3.non_discountable_revenue).to eq(65)
      expect(invoice4.non_discountable_revenue).to eq(115)
    end
  end
end


# expect(invoice1.revenue_after_discount).to eq(235)
#break down problem and find max percentage_discount

# discount2 = Discount.create!(percentage_discount: 20, quantity_threshold: 20, merchant_id: merchant1.id)
# discount3 = Discount.create!(percentage_discount: 30, quantity_threshold: 30, merchant_id: merchant1.id)
#What do I want to get back from query????
#specific InvoiceItems? Quantity * Unit Price???
# max_percent_discount_1 =
# max_percent_discount_2 =
# max_percent_discount_3 =
# max_percent_discount_4 =
# expect(invoice1.qualified_items(max_percent_discount_1).to eq()
# expect(invoice2.qualified_items(max_percent_discount_2).to eq()
# expect(invoice3.qualified_items(max_percent_discount_3).to eq()
# expect(invoice4.qualified_items(max_percent_discount_4).to eq()
#CHANGE TO REVENUE FOR BULK DISOCUNT????
