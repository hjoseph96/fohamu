class CreateDonors < ActiveRecord::Migration[6.1]
  def change
    create_table :donors do |t|
      t.string :full_name
      t.string :email
      t.string :phone_number
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :customer_id

      t.timestamps
    end
  end
end
