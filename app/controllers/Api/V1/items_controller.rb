class Api::V1::ItemsController < ApplicationController
  def index
    items = ObjectsFacade.all_objects_helper(Item, params)
    render json: ItemSerializer.new(items).serializable_hash
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item).serializable_hash
  end
end