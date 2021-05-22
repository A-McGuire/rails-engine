class Api::V1::MerchantsController < ApplicationController
  def index
    if params[:page].present?
      merchants = Merchant.all_merchants(params[:page])
    else
      merchants = Merchant.all_merchants(1)
    end
    render json: MerchantSerializer.new(merchants).serializable_hash
  end
end