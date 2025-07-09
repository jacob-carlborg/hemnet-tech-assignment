class MovePricesToMunicipalities < ActiveRecord::Migration[7.1]
  class Price < ActiveRecord::Base
  end

  class Package < ActiveRecord::Base
  end

  class Municipality < ActiveRecord::Base
  end

  def up
    premium = Package.find_by!(name: "premium")
    plus = Package.find_by!(name: "plus")
    basic = Package.find_by!(name: "basic")

    Municipality.insert_all([
      {package_id: premium.id, name: "Göteborg", amount_cents: premium.amount_cents},
      {package_id: plus.id, name: "Göteborg", amount_cents: plus.amount_cents},
      {package_id: basic.id, name: "Göteborg", amount_cents: basic.amount_cents}
    ], unique_by: %i[name package_id])

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
end
