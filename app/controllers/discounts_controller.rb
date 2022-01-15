class DiscountsController < ApplicationController
  def index
    @discounts = Discount.all
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @discount = Discount.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = Discount.new(quantity_threshold: params["Quantity Threshold"], percentage_discount: params["Percent Discount"], merchant_id: merchant.id)

    discount.save
  end

  def edit
    @discount = Discount.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    discount = Discount.update(quantity_threshold: params["Quantity Threshold"], percentage_discount: params["Percent Discount"], merchant_id: merchant.id)
  end

  def destroy
    discount = Discount.find(params[:id])

    discount.destroy

    redirect_to merchant_discounts_path(params[:merchant_id])
  end
end
