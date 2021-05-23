class Api::V1::ItemsController < ApplicationController
  def index
    merchant_items = Item.merchant_items(params[:merchant_id])
    render json: ItemSerializer.new(merchant_items).serializable_hash
  end
end