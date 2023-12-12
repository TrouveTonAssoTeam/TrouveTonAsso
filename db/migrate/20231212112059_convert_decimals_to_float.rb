class ConvertDecimalsToFloat < ActiveRecord::Migration[7.1]
  def change
    change_column :cagnottes, :amount, :decimal, precision: 10, scale: 2
    change_column :donations, :amount, :decimal, precision: 10, scale: 2
    change_column :withdrawals, :amount, :decimal, precision: 10, scale: 2
  end
end
