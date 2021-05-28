class Api::V1::RevenueController < ApplicationController

  include Validable

  def index
    return render json: {status: 400, error: 'Invalid Parameters'}, status: 400 unless valid_start_end_dates?(params[:start], params[:end])
    revenue = Invoice.total_revenue_by_dates(params[:start], params[:end])
    render json: {data: {id: nil, type: 'revenue', attributes: {revenue: revenue}}}
  end

  def show
    merchant = Merchant.find(params[:merchant_id])
    merchant_revenue = merchant.total_revenue
    render json: {data: {id: merchant.id.to_s, type: 'merchant_revenue', attributes: {revenue: merchant_revenue}}}
  end
end
