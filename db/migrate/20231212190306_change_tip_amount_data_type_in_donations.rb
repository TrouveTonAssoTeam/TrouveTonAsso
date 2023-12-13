class ChangeTipAmountDataTypeInDonations < ActiveRecord::Migration[7.1]
  def change
    change_column :donations, :tip_amount, :integer
  end
end
