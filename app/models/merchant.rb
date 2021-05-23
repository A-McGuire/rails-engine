class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items, dependent: :destroy
  
  class << self
    def merchant_items(merchant_id)
      find(merchant_id).items
    end
  end
end