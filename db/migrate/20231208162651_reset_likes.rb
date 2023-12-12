class ResetLikes < ActiveRecord::Migration[7.1]
  def change
    drop_table :likes
    create_table :likes do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :organisation, foreign_key: true

      t.timestamps
    end
  end
end
