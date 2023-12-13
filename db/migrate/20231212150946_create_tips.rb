class CreateTips < ActiveRecord::Migration[7.1]
  def change
    create_table :tips do |t|
      t.decimal :amount
      t.references :donation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
