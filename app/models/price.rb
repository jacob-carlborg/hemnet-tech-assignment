# frozen_string_literal: true

class Price < ApplicationRecord
  belongs_to :municipality, optional: false

  validates :amount_cents, presence: true
end
