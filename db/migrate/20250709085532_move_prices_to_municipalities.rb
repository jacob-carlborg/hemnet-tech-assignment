class MovePricesToMunicipalities < ActiveRecord::Migration[7.1]
  class Price < ActiveRecord::Base
  end

  class Package < ActiveRecord::Base
  end

  class Municipality < ActiveRecord::Base
  end

  def up
    create_municipality_for_package(name: "premium")
    create_municipality_for_package(name: "plus")
    create_municipality_for_package(name: "basic")

    Price.update_all <<~SQL
      municipality_id = (
        SELECT id FROM municipalities
        WHERE municipalities.name = 'Göteborg'
        AND municipalities.package_id = prices.package_id
        LIMIT 1
      )
    SQL
  end

  def down
    Price.update_all(municipality_id: nil)
    Municipality.connection.truncate(Municipality.table_name)
  end

  def create_municipality_for_package(name:)
    package = Package.find_by(name:)
    return unless package

    Municipality.create!(package:, name: "Göteborg", amount_cents: package.amount_cents)
  end
end
