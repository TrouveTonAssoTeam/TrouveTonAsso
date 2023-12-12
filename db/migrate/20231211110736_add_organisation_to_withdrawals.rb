class AddOrganisationToWithdrawals < ActiveRecord::Migration[7.1]
  def change
    add_reference :withdrawals, :organisation, null: false, foreign_key: true
  end
end
