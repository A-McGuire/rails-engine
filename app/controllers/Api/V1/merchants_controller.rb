class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = MerchantFacade.all_merchants_helper(params)
    render json: MerchantSerializer.new(merchants).serializable_hash
  end
end