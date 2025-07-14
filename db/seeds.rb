# frozen_string_literal: true

puts "Removing old packages and their price histories"
Price.connection.truncate(Price.table_name)
Municipality.connection.truncate(Municipality.table_name)
Package.connection.truncate(Package.table_name)

puts "Creating new packages"

Package.insert_all([
  {id: 1, name: "basic"},
  {id: 2, name: "plus"},
  {id: 3, name: "premium"}
])

Municipality.insert_all([
  # basic
  {id: 1, name: "Göteborg", amount_cents: 200_00, package_id: 1},

  # plus
  {id: 2, name: "Göteborg", amount_cents: 599_00, package_id: 2},
  {id: 3, name: "Stockholm", amount_cents: 699_00, package_id: 2},

  # premium
  {id: 4, name: "Göteborg", amount_cents: 1_111_00, package_id: 3},
  {id: 5, name: "Stockholm", amount_cents: 1_222_00, package_id: 3}
])

Price.insert_all([
  # basic Göteborg
  {amount_cents: 50_00, municipality_id: 1},
  {amount_cents: 100_00, municipality_id: 1},

  # plus Göteborg
  {amount_cents: 199_00, municipality_id: 2},
  {amount_cents: 299_00, municipality_id: 2},
  {amount_cents: 399_00, municipality_id: 2},

  # plus Stockholm
  {amount_cents: 499_00, municipality_id: 3},

  # premium Göteborg
  {amount_cents: 555_00, municipality_id: 4},
  {amount_cents: 666_00, municipality_id: 4},
  {amount_cents: 777_00, municipality_id: 4},
  {amount_cents: 888_00, municipality_id: 4},

  # premium Stockholm
  {amount_cents: 988_00, municipality_id: 5}
])
