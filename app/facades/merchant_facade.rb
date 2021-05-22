class MerchantFacade
  class << self
    def all_merchants_helper(params)
      return Merchant.all_merchants() if params[:page].nil? && params[:per_page].nil?
      return Merchant.all_merchants(1, params[:per_page].to_i) if params[:per_page].present?
      return Merchant.all_merchants(params[:page].to_i) if params[:page].present?
    end
  end
end