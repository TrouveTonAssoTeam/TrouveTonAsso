class CagnotteStatus < ActiveRecord::Migration[7.1]
  def change
      create_table :cagnotte_status do |t|
      t.integer :amount
      t.integer :organisation_id
      t.string :status

      t.timestamps
      end
  end
end
