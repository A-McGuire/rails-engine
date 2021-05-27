class Api::V1::Merchants::MerchantsSearchController < ApplicationController

  include Validable

  def find_one
    return render status: 400 unless valid_name?(params[:name])
    merchant = Merchant.find_one(params[:name])
    return render json: MerchantSerializer.new(merchant).serializable_hash if merchant
    render json: {data: {}}, status: :ok
  end
end