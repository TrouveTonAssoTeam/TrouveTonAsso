class AddFieldsToOrganisations < ActiveRecord::Migration[7.1]
  def change
    add_column :organisations, :name, :string
    add_column :organisations, :description, :text
    add_column :organisations, :city, :string
    add_column :organisations, :website, :string
  end
end
