class Api::V1::Items::ItemsSearchController < ApplicationController

  include Validable

  def find_all
    if params[:name]
      return render status: 400 unless valid_name?(params[:name])
      items = Item.find_all(params[:name])
      return render json: ItemSerializer.new(items).serializable_hash if items
      render json: {data: []}, status: :ok
    elsif params[:min_price] && params[:max_price] || params[:max_price] || params[:min_price]
      return render status: 400 unless valid_min_max(params[:min_price], params[:max_price])
      params[:min_price] ||= 0
      params[:max_price] ||= 9999999999
      items = Item.find_by_min_max(params[:min_price], params[:max_price])
      return render json: ItemSerializer.new(items).serializable_hash if items
      render json: {data: []}, status: :ok
    end
    render status: 400
  end
end