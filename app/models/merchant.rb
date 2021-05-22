class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items, dependent: :destroy
  class << self
    def all_merchants(page_number = 1, per_page = 20)
      Merchant.all.limit(20).offset((page_number - 1) * 20)
    end

    def merchant(id)
      find(id)
    end
  end
end