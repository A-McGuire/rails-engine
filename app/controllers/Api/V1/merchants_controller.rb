class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = ObjectsFacade.all_objects_helper(Merchant, params)
    render json: MerchantSerializer.new(merchants).serializable_hash
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.new(merchant).serializable_hash
  end

  def most_revenue
    merchants = Merchant.by_total_revenue(params[:quantity])
    render json: { status: "error", code: 400, message: "Quantity parameter required" } unless merchants
    render json: MerchantNameRevenueSerializer.new(merchants).serializable_hash
  end

  def most_items
    merchants = Merchant.most_items_sold(params[:quantity])
    render json: { status: "error", code: 400, message: "Quantity parameter required" } unless merchants
    render json: ItemsSoldSerializer.new(merchants).serializable_hash
  end
end