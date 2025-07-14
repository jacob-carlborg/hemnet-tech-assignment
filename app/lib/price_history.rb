# frozen_string_literal: true

class PriceHistory
  def self.call(year:, package:, municipality: nil)
    new(year:, package:, municipality:).history
  end

  def initialize(year:, package:, municipality:)
    @year = year
    @package = package
    @municipality = municipality
  end

  def history
    Municipality
      .joins(:package, :prices)
      .includes(:prices)
      .where(conditions)
      .map { [_1.name, _1.prices.pluck(:amount_cents).sort] }
      .to_h
  end

  private

  attr_reader :year
  attr_reader :package
  attr_reader :municipality

  def year_range = @year_range ||= Time.zone.parse("#{year}-01-01").all_year

  def conditions
    @conditions ||= {
      package: {name: package},
      prices: {created_at: year_range},
      **municipality_condition
    }
  end

  def municipality_condition
    @municipality_condition ||=
      municipality.present? ? {name: municipality} : {}
  end
end
