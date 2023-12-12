class AddCagnotteToOrganisations < ActiveRecord::Migration[7.1]
  def change
    add_column :organisations, :cagnotte, :integer
  end
end
