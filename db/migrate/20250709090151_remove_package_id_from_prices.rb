class RemovePackageIdFromPrices < ActiveRecord::Migration[7.1]
  def change
    remove_column :prices, :package_id, :integer
  end
end
