class Api::V1::RevenueController < ApplicationController

  include Validable

  def index
    return render json: {status: 400, error: 'Invalid Parameters'}, status: 400 unless valid_start_end_dates?(params[:start], params[:end])
    revenue = Invoice.total_revenue_by_dates(params[:start], params[:end])
    render json: {data: {id: nil, type: 'revenue', attributes: {revenue: revenue}}}
  end
end
