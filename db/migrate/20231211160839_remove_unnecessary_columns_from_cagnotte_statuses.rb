class RemoveUnnecessaryColumnsFromCagnotteStatuses < ActiveRecord::Migration[7.1]
  def change
    remove_column :cagnotte_statuses, :amount, :integer
    remove_column :cagnotte_statuses, :organisation_id, :integer
  end
end
