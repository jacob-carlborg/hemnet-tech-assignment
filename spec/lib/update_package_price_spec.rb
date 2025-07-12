# frozen_string_literal: true

require "spec_helper"

RSpec.describe UpdatePackagePrice do
  it "updates the current price of the provided municipality" do
    package = Package.create!(name: "Dunderhonung")
    municipality = Municipality.create!(name: "Göteborg", package:)

    UpdatePackagePrice.call(municipality, 200_00)
    expect(municipality.reload.amount_cents).to eq(200_00)
  end

  it "only updates the passed municipality price" do
    package = Package.create!(name: "Dunderhonung")
    municipality = Municipality.create!(name: "Göteborg", package:)
    other_municipality = Municipality.create!(name: "Stockholm", package:, amount_cents: 100_00)

    expect {
      UpdatePackagePrice.call(municipality, 200_00)
    }.not_to change {
      other_municipality.reload.amount_cents
    }
  end

  it "stores the old price of the provided package in its price history" do
    package = Package.create!(name: "Dunderhonung")
    municipality = Municipality.create!(name: "Göteborg", package:, amount_cents: 100_00)

    UpdatePackagePrice.call(municipality, 200_00)

    expect(municipality.prices).to contain_exactly(
      an_object_having_attributes(amount_cents: 100_00)
    )
  end
end
