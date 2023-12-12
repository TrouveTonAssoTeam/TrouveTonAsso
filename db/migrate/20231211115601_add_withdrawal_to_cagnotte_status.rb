class AddWithdrawalToCagnotteStatus < ActiveRecord::Migration[7.1]
  def change
    add_reference :cagnotte_statuses, :withdrawal, null: false, foreign_key: true
  end
end
