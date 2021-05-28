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

  def valid_start_end_dates?(start_time, end_time)
    return false if start_time.nil? || end_time.nil?
    true
  end
end