class CreateAssociationProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :association_profiles do |t|
      t.references :association, foreign_key: true # Référence à la table association
      t.text :description
      t.string :cover_photo

      t.timestamps
    end
  end
end
