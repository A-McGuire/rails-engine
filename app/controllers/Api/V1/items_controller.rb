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
    else
      render json: item.errors, status: :unprocessable_entity
    end
    item.delete
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      render json: ItemSerializer.new(item).serializable_hash, status: :ok
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end