class ChangeFieldsOfAsso < ActiveRecord::Migration[7.1]
  def change
    remove_column :organisations, :website, :string
    add_column :organisations, :address, :string
    add_column :organisations, :zip, :string
    add_column :organisations, :rna, :string
  end
end
