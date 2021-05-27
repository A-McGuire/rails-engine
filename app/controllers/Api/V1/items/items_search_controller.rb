class Api::V1::Items::ItemsSearchController < ApplicationController

  include Validable

  def find_all
    return render status: 400 unless valid_name?(params[:name])
    items = Item.find_all(params[:name])
    return render json: ItemSerializer.new(items).serializable_hash if items
    render json: {data: []}, status: :ok
  end
end