class Api::V1::RevenueController < ApplicationController
  def index
    # return render status: 400 unless valid_quantity?(params[:quantity])
    revenue = Invoice.total_revenue_by_dates(params[:start], params[:end])
    render json: {data: {id: nil, type: 'revenue', attributes: {revenue: revenue}}}
  end
end
