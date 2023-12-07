class CreateDonations < ActiveRecord::Migration[7.1]
  def change
    create_table :donations do |t|
      t.integer :amount
      t.integer :organisation_id
      t.integer :user_id

      t.timestamps
    end
  end
end
