class Municipality < ApplicationRecord
  belongs_to :package
  has_many :prices

  validates :name, presence: true
  validates :amount_cents, presence: true
end
