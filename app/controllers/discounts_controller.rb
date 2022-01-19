class DiscountsController < ApplicationController
  def index
    @discounts = Merchant.find(params[:merchant_id]).discounts
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
    discount = merchant.discounts.new(discount_params)
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
    discount = Discount.find(params[:id])
    merchant = Merchant.find(params[:merchant_id])

    if discount.update(discount_params)
      redirect_to merchant_discount_path(merchant, discount)
    else
      error_message = discount.errors.full_messages.to_sentence
      flash[:notice] = "Discount not Created: #{error_message}"

      redirect_to edit_merchant_discount_path(merchant, discount)
    end
  end

  def destroy
    discount = Discount.find(params[:id])

    discount.destroy

    redirect_to merchant_discounts_path(params[:merchant_id])
  end

  private

  def discount_params
    params.permit(:quantity_threshold, :percentage_discount)
  end
end
