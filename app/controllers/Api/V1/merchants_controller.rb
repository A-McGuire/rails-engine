class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = ObjectsFacade.all_objects_helper(Merchant, params)
    render json: MerchantSerializer.new(merchants).serializable_hash
  end

  def show
    merchant = Merchant.find(params[:id])
    var = render json: MerchantSerializer.new(merchant).serializable_hash
  end
end