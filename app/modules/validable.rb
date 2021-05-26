module Validable
  def valid_quantity?(quantity)
    return true if quantity.to_i > 0
    false
  end
end