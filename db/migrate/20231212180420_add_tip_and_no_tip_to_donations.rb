class AddTipAndNoTipToDonations < ActiveRecord::Migration[7.1]
  def change
    add_column :donations, :tip_amount, :decimal
    add_column :donations, :no_tip, :decimal, precision: 10, scale: 2
  end
end
