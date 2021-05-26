class ItemsSoldSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :item_count
end
