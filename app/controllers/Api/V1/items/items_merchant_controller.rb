class Api::V1::Items::ItemsMerchantController < ApplicationController
  def index
    items_merchant = Item.items_merchant(params[:item_id])
    render json: MerchantSerializer.new(items_merchant).serializable_hash
  end
end