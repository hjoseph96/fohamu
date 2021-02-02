class CreateDonations < ActiveRecord::Migration[6.1]
  def change
    create_table :donations do |t|
      t.integer :price_in_cents, null: false, default: nil
      t.string :currency
      t.integer :frequency
      t.datetime :last_payment_date
      t.integer :donor_id, foreign_key: true

      t.timestamps
    end

    add_index :donations, :donor_id
  end
end
