class AddColumnsToCagnotte < ActiveRecord::Migration[7.1]
  def change
    add_column :cagnottes, :amount, :integer
    add_column :cagnottes, :organisation_id, :integer
  end
end
