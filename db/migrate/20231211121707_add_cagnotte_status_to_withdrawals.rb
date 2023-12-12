class AddCagnotteStatusToWithdrawals < ActiveRecord::Migration[7.1]
  def change
    add_reference :withdrawals, :cagnotte_status, foreign_key: true, null: true
  end
end
