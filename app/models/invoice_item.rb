class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item

  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  def percent_discount_to_apply
      Discount.all.where('discounts.quantity_threshold <= ?', "#{self.quantity}")
      .where('discounts.merchant_id = ?', "#{self.item.merchant_id}")
      .order(:percentage_discount)
      .pluck(:percentage_discount).last
  end

  def pre_discount_revenue
    unit_price * quantity
  end

  def discounted_revenue
    self.percent_discount_to_apply
  end
end
