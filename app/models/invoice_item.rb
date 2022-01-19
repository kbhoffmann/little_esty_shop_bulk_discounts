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
    Discount.where("discounts.quantity_threshold <= #{self.quantity} AND discounts.merchant_id = #{self.item.merchant_id}")
            .pluck(:percentage_discount).max
  end

  def pre_discount_revenue
    unit_price * quantity
  end

  def discounted_revenue
    if percent_discount_to_apply
      pre_discount_revenue - (pre_discount_revenue * (percent_discount_to_apply.to_f/100))
    else
      pre_discount_revenue
    end
  end
end
