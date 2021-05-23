class Api::V1::ItemsController < ApplicationController
  def index
    if params[:merchant_id].present?
      merchant_items = Merchant.merchant_items(params[:merchant_id])
      return render json: ItemSerializer.new(merchant_items).serializable_hash
    end
    items = ItemFacade.all_items_helper(params)
    render json: ItemSerializer.new(items).serializable_hash
  end
end