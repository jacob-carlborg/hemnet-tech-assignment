class Municipality < ApplicationRecord
  belongs_to :package

  validates :name, presence: true
  validates :amount_cents, presence: true
end
