class MerchantsByRevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :revenue
end
