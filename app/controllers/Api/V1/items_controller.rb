class Api::V1::ItemsController < ApplicationController
  def index
    items = ObjectsFacade.all_objects_helper(Item, params)
    render json: ItemSerializer.new(items).serializable_hash
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item).serializable_hash
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.new(item).serializable_hash, status: :created
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end