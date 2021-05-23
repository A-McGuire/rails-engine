class ItemFacade
  class << self
    def all_items_helper(params) #TODO: test?
      return Item.all_items() if params[:page].nil? && params[:per_page].nil?
      return Item.all_items(params[:page].to_i, params[:per_page].to_i) if params[:page].present? && params[:per_page].present?
      return Item.all_items(1, params[:per_page].to_i) if params[:per_page].present?
      return Item.all_items(params[:page].to_i) if params[:page].present?
    end
  end
end