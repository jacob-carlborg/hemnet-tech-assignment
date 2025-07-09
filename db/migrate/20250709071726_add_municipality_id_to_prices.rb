class AddMunicipalityIdToPrices < ActiveRecord::Migration[7.1]
  def change
    add_reference :prices, :municipality, foreign_key: true
  end
end
