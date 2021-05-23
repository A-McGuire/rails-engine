class Api::V1::MerchantController < ApplicationController
  def index
    items_merchant = Item.find(params[:item_id]).merchant
    render json: MerchantSerializer.new(items_merchant).serializable_hash
  end
end
