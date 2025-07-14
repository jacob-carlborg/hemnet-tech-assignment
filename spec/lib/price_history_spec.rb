require "spec_helper"

RSpec.describe PriceHistory do
  describe "call" do
    let(:package) { Package.create!(name: "premium") }
    let(:stockholm) { Municipality.create!(name: "Stockholm", package:) }
    let(:göteborg) { Municipality.create!(name: "Göteborg", package:) }

    before do
      Price.create!(amount_cents: 100_00, municipality: stockholm, created_at: "2023-04-01")
      Price.create!(amount_cents: 125_00, municipality: stockholm, created_at: "2023-08-02")
      Price.create!(amount_cents: 175_00, municipality: stockholm, created_at: "2023-12-24")

      Price.create!(amount_cents: 25_00, municipality: göteborg, created_at: "2022-09-01")
      Price.create!(amount_cents: 50_00, municipality: göteborg, created_at: "2023-02-03")
      Price.create!(amount_cents: 75_00, municipality: göteborg, created_at: "2023-05-20")

      bas = Package.create!(name: "bas")
      municipality = Municipality.create!(name: "Göteborg", package: bas)
      Price.create!(amount_cents: 100_00, municipality:)
    end

    it "returns the price history by municipality with prices sorted" do
      expect(described_class.call(year: "2023", package: "premium")).to eq(
        "Stockholm" => [100_00, 125_00, 175_00],
        "Göteborg" => [50_00, 75_00]
      )
    end

    context "when filtering by municipality" do
      it "returns the price history only for the specified municipality" do
        result = described_class.call(
          year: "2023",
          package: "premium",
          municipality: "Göteborg"
        )

        expect(result).to eq("Göteborg" => [50_00, 75_00])
      end
    end
  end
end
