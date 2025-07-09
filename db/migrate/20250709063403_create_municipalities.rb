class CreateMunicipalities < ActiveRecord::Migration[7.1]
  def change
    create_table :municipalities do |t|
      t.string :name, null: false
      t.integer :amount_cents, null: false
      t.belongs_to :package, null: false, foreign_key: true

      t.timestamps
      t.index %i[name package_id], unique: true
    end
  end
end
