class DiscountsController < ApplicationController
  def index
    @discounts = Discount.all
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show

  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = Discount.new(quantity_threshold: params["Quantity Threshold"], percentage_discount: params["Percent Discount"], merchant_id: merchant.id)

    discount.save
  end
end
