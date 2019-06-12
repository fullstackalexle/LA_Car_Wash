class Wash < ApplicationRecord
  validates :vehicle, presence: true
  validates :sales_price, presence: true
  validates :total_price, presence: true

  belongs_to :vehicle
end
