class RenameCagnotteStatusToCagnotteStatuses < ActiveRecord::Migration[7.1]
  def change
    rename_table :cagnotte_status, :cagnotte_statuses
  end
end
