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
    if params[:quantity]
      merchants = Merchant.by_total_revenue(params[:quantity])
      render json: MerchantsByRevenueSerializer.new(merchants).serializable_hash
    else
      binding.pry
      render json: { status: "error", code: 400, message: "Quantity parameter required" }
    end
  end
end