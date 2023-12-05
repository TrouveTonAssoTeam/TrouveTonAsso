class AddAssociationIdToAssociationProfiles < ActiveRecord::Migration[7.1]
  def change
    add_column :association_profiles, :association_id, :integer
  end
end
