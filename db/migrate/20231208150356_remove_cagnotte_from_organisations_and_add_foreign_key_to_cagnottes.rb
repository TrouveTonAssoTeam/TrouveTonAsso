class RemoveCagnotteFromOrganisationsAndAddForeignKeyToCagnottes < ActiveRecord::Migration[7.1]
  def change
    remove_column :organisations, :cagnotte, :integer
    remove_column :cagnottes, :organisation_id, :integer
    add_reference :cagnottes, :organisation, foreign_key: true
  end
end
