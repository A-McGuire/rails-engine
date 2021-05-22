class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items, dependent: :destroy

  def self.all_merchants(page_number)
    Merchant.all.limit(20).offset((page_number - 1) * 20)
  end
end