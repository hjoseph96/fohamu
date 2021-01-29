class CreateDonations < ActiveRecord::Migration[6.1]
  def change
    create_table :donations do |t|
      t.integer :price_in_cents, null: false, default: nil
      t.string :currency
      t.integer :frequency

      t.timestamps
    end
  end
end
