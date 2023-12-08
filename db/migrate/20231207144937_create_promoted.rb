class CreatePromoted < ActiveRecord::Migration[7.1]
  def change
    create_table :promoteds do |t|
      t.date :start_date
      t.date :end_date
      t.integer :organisation_id
      t.float :price
      t.string :stripe_id

      t.timestamps
    end
  end
end
