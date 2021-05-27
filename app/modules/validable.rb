module Validable
  def valid_quantity?(quantity)
    return true if quantity.to_i > 0
    false
  end

  def valid_name?(name)
    return true if name && name.class == String
    false
  end

  def valid_min_max(min, max)
    return false if min.nil? && max.nil?
    return true if min.to_i > 0 || max.to_i > 0
    false
  end
end