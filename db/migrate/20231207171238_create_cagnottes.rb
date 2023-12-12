class CreateCagnottes < ActiveRecord::Migration[7.1]
  def change
    create_table :cagnottes do |t|

      t.timestamps
    end
  end
end
