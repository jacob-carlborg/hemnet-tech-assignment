# frozen_string_literal: true

class UpdatePackagePrice
  def self.call(municipality, new_price_cents, **options)
    Package.transaction do
      # Add a pricing history record
      Price.create!(municipality:, amount_cents: municipality.amount_cents)

      # Update the current price
      municipality.update!(amount_cents: new_price_cents)
    end
  end
end
