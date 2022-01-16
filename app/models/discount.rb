class Discount < ApplicationRecord
  belongs_to :merchant
  validates :percentage_discount, presence: true, numericality: {greater_than: 0}
  validates :quantity_threshold, presence: true, numericality: {greater_than: 0}
  validates_numericality_of :quantity_threshold, only_integer: true
end
