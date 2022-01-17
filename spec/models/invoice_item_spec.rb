require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "validations" do
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
  end

  describe "relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end

  describe "class methods" do
    before(:each) do
      @m1 = Merchant.create!(name: 'Merchant 1')
      @c1 = Customer.create!(first_name: 'Bilbo', last_name: 'Baggins')
      @c2 = Customer.create!(first_name: 'Frodo', last_name: 'Baggins')
      @c3 = Customer.create!(first_name: 'Samwise', last_name: 'Gamgee')
      @c4 = Customer.create!(first_name: 'Aragorn', last_name: 'Elessar')
      @c5 = Customer.create!(first_name: 'Arwen', last_name: 'Undomiel')
      @c6 = Customer.create!(first_name: 'Legolas', last_name: 'Greenleaf')
      @item_1 = Item.create!(name: 'Shampoo', description: 'This washes your hair', unit_price: 10, merchant_id: @m1.id)
      @item_2 = Item.create!(name: 'Conditioner', description: 'This makes your hair shiny', unit_price: 8, merchant_id: @m1.id)
      @item_3 = Item.create!(name: 'Brush', description: 'This takes out tangles', unit_price: 5, merchant_id: @m1.id)
      @i1 = Invoice.create!(customer_id: @c1.id, status: 2)
      @i2 = Invoice.create!(customer_id: @c1.id, status: 2)
      @i3 = Invoice.create!(customer_id: @c2.id, status: 2)
      @i4 = Invoice.create!(customer_id: @c3.id, status: 2)
      @i5 = Invoice.create!(customer_id: @c4.id, status: 2)
      @ii_1 = InvoiceItem.create!(invoice_id: @i1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
      @ii_2 = InvoiceItem.create!(invoice_id: @i1.id, item_id: @item_2.id, quantity: 1, unit_price: 8, status: 0)
      @ii_3 = InvoiceItem.create!(invoice_id: @i2.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 2)
      @ii_4 = InvoiceItem.create!(invoice_id: @i3.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 1)
    end
    it 'incomplete_invoices' do
      expect(InvoiceItem.incomplete_invoices).to eq([@i1, @i3])
    end
  end

  describe "instance methods for Bulk Discounts Project" do
    it 'tests Example 1' do
      merchantA = Merchant.create!(name: 'Hair Care')
      customer1 = Customer.create!(first_name: 'Brooke', last_name: 'Stewart')
      invoiceA = Invoice.create!(customer_id: customer1.id, status: 2)
      transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoiceA.id)
      itemA = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: merchantA.id, status: 1)
      itemB = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: merchantA.id, status: 1)

      iiA = InvoiceItem.create!(invoice_id: invoiceA.id, item_id: itemA.id, quantity: 5, unit_price: 10, status: 2)
      iiB = InvoiceItem.create!(invoice_id: invoiceA.id, item_id: itemB.id, quantity: 5, unit_price: 8, status: 2)
      discountA = Discount.create!(percentage_discount: 20, quantity_threshold: 10, merchant_id: merchantA.id)

      expect(iiA.percent_discount_to_apply).to eq(nil)
      expect(iiB.percent_discount_to_apply).to eq(nil)
    end

    it 'tests Example 2' do
      merchantA = Merchant.create!(name: 'Hair Care')
      customer1 = Customer.create!(first_name: 'Brooke', last_name: 'Stewart')
      invoiceA = Invoice.create!(customer_id: customer1.id, status: 2)
      transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoiceA.id)
      itemA = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: merchantA.id, status: 1)
      itemB = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: merchantA.id, status: 1)

      iiA = InvoiceItem.create!(invoice_id: invoiceA.id, item_id: itemA.id, quantity: 10, unit_price: 10, status: 2)
      iiB = InvoiceItem.create!(invoice_id: invoiceA.id, item_id: itemB.id, quantity: 5, unit_price: 8, status: 2)
      discountA = Discount.create!(percentage_discount: 20, quantity_threshold: 10, merchant_id: merchantA.id)

      expect(iiA.percent_discount_to_apply).to eq(20)
      expect(iiB.percent_discount_to_apply).to eq(nil)
    end

    it 'tests Example 3' do
      merchantA = Merchant.create!(name: 'Hair Care')
      customer1 = Customer.create!(first_name: 'Brooke', last_name: 'Stewart')
      invoiceA = Invoice.create!(customer_id: customer1.id, status: 2)
      transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoiceA.id)
      itemA = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: merchantA.id, status: 1)
      itemB = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: merchantA.id, status: 1)

      iiA = InvoiceItem.create!(invoice_id: invoiceA.id, item_id: itemA.id, quantity: 12, unit_price: 10, status: 2)
      iiB = InvoiceItem.create!(invoice_id: invoiceA.id, item_id: itemB.id, quantity: 15, unit_price: 8, status: 2)
      discountA = Discount.create!(percentage_discount: 20, quantity_threshold: 10, merchant_id: merchantA.id)
      discountB = Discount.create!(percentage_discount: 30, quantity_threshold: 15, merchant_id: merchantA.id)

      expect(iiA.percent_discount_to_apply).to eq(20)
      expect(iiB.percent_discount_to_apply).to eq(30)
    end

    it 'tests Example 4' do
      merchantA = Merchant.create!(name: 'Hair Care')
      customer1 = Customer.create!(first_name: 'Brooke', last_name: 'Stewart')
      invoiceA = Invoice.create!(customer_id: customer1.id, status: 2)
      transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoiceA.id)
      itemA = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: merchantA.id, status: 1)
      itemB = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: merchantA.id, status: 1)

      iiA = InvoiceItem.create!(invoice_id: invoiceA.id, item_id: itemA.id, quantity: 12, unit_price: 10, status: 2)
      iiB = InvoiceItem.create!(invoice_id: invoiceA.id, item_id: itemB.id, quantity: 15, unit_price: 8, status: 2)
      discountA = Discount.create!(percentage_discount: 20, quantity_threshold: 10, merchant_id: merchantA.id)
      discountB = Discount.create!(percentage_discount: 15, quantity_threshold: 15, merchant_id: merchantA.id)

      expect(iiA.percent_discount_to_apply).to eq(20)
      expect(iiB.percent_discount_to_apply).to eq(20)
    end

    it 'tests Example 5' do
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

      expect(iiA.percent_discount_to_apply).to eq(20)
      expect(iiB.percent_discount_to_apply).to eq(30)
      expect(iiC.percent_discount_to_apply).to eq(nil)
    end

    it 'calculates revenue for an invoice item before any discounts applied' do
      merchantA = Merchant.create!(name: 'Hair Care')
      merchantB = Merchant.create!(name: 'Pet Stuff')
      customer1 = Customer.create!(first_name: 'Brooke', last_name: 'Stewart')
      invoiceA = Invoice.create!(customer_id: customer1.id, status: 2)
      transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoiceA.id)
      itemA = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: merchantA.id, status: 1)
      itemB = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: merchantA.id, status: 1)
      itemC = Item.create!(name: "Dog Food", description: "Food for the Dog", unit_price: 25, merchant_id: merchantB.id, status: 1)

      iiA = InvoiceItem.create!(invoice_id: invoiceA.id, item_id: itemA.id, quantity: 12, unit_price: 10, status: 2)
      iiB = InvoiceItem.create!(invoice_id: invoiceA.id, item_id: itemB.id, quantity: 15, unit_price: 10, status: 2)
      iiC = InvoiceItem.create!(invoice_id: invoiceA.id, item_id: itemC.id, quantity: 15, unit_price: 25, status: 2)
      discountA = Discount.create!(percentage_discount: 20, quantity_threshold: 10, merchant_id: merchantA.id)
      discountB = Discount.create!(percentage_discount: 30, quantity_threshold: 15, merchant_id: merchantA.id)

      expect(iiA.pre_discount_revenue).to eq(120)
      expect(iiB.pre_discount_revenue).to eq(150)
      expect(iiC.pre_discount_revenue).to eq(375)
    end

    xit 'calculates discounted revenue for each invoice item' do
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

      expect(iiA.discounted_revenue).to eq(96)
      expect(iiB.discounted_revenue).to eq(84)
      # expect(iiC.discounted_revenue).to eq(nil)
    end
  end
end
