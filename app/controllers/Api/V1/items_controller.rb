class Api::V1::ItemsController < ApplicationController
  before_action :find_item, only: [:show, :update, :destroy]

  def find_item
    Item.find(params[:id])
  end

  def index
    items = ObjectsFacade.all_objects_helper(Item, params)
    render json: ItemSerializer.new(items).serializable_hash
  end

  def show
    item = find_item
    render json: ItemSerializer.new(item).serializable_hash
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.new(item).serializable_hash, status: :created
    else
      render json: item.errors, status: :unprocessable_entity
    end
    item.delete # TODO: Remove
  end

  def update
    item = find_item
    if item.update(item_params)
      render json: ItemSerializer.new(item).serializable_hash, status: :ok
    else
      render json: item.errors, status: :not_found
    end
  end

  def destroy
    item = find_item
    item.destroy
    invoices = Invoice.find_empty
    invoices.destroy_all
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end