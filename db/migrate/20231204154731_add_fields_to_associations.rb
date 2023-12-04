class AddFieldsToAssociations < ActiveRecord::Migration[7.1]
  def change
    add_column :associations, :name, :string
    add_column :associations, :description, :text
    add_column :associations, :city, :string
    add_column :associations, :website, :string
  end
end
