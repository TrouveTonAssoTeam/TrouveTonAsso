class ChangeFieldsOfAsso < ActiveRecord::Migration[7.1]
  def change
    remove_column :associations, :website, :string
    add_column :associations, :address, :string
    add_column :associations, :zip, :string
    add_column :associations, :rna, :string
  end
end
