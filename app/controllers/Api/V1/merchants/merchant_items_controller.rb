class Api::V1::Merchants::MerchantItemsController < ApplicationController
  def index
    merchant_items = Merchant.merchant_items(params[:merchant_id])
    render json: ItemSerializer.new(merchant_items).serializable_hash
  end
end