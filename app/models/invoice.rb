class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, 'in progress', :complete]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def max_percent_discount
    invoice_items.joins(item: {merchant: :discounts})
          .where('invoice_items.quantity >= discounts.quantity_threshold')
          .select('discounts.percentage_discount, invoice_items.*')
          .order('discounts.percentage_discount')
          .pluck('discounts.percentage_discount').last
          #later call .max??????
  end

  def qualified_items
    #items in the invoice that qualify for the discount
    #Items .where('invoice_items.quantity >= discounts.quantity_threshold')
    #write lots of tests
  end

  def unqualified_items
    #items in the invoice that don't qualitfy for the discount
    #Items .where('invoice_items.quantity < discounts.quantity_threshold')
    #write lots of tests
  end

  # qualified_items_revenue * max_percent_discount
  # unqualified_items_revenue
  # add the two together to get the discounted revenue
  # may need if statements
end
