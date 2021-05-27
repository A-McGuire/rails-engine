module Validable
  def valid_quantity?(quantity)
    return true if quantity.to_i > 0
    false
  end

  def valid_name?(name)
    return true if name && name.class == String
    false
  end
end