class Discount < ApplicationRecord
  belongs_to :merchant
  validates :percentage_discount, presence: true, numericality: {greater_than: 0}
  validates :quantity_threshold, presence: true, numericality: {greater_than: 0}
end
