# frozen_string_literal: true

class Package < ApplicationRecord
  has_many :municipalities, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
