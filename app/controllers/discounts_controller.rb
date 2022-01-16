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
    discount = merchant.discounts.new(quantity_threshold: params["Quantity Threshold"], percentage_discount: params["Percent Discount"])
    if discount.save
      redirect_to merchant_discounts_path(merchant.id)
    else
      error_message = discount.errors.full_messages.to_sentence
      flash[:notice] = "Discount not Created: #{error_message}"

      redirect_to new_merchant_discount_path(merchant.id)
    end
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
