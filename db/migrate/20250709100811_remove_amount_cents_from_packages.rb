class RemoveAmountCentsFromPackages < ActiveRecord::Migration[7.1]
  def change
    remove_column :packages, :amount_cents, :integer, default: 0, null: false
  end
end
