class ItemsSoldSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
  attribute :count do |object|
    object.item_count
  end
end
