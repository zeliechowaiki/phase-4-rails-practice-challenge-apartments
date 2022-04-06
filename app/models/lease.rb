class Lease < ApplicationRecord
  belongs_to :apartment
  belongs_to :tenant
  validates :rent, numericality: true
  validates :apartment, presence: true
  validates :tenant, presence: true
end
