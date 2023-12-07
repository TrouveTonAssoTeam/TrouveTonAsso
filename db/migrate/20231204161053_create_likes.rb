class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :organisations, foreign_key: true
      t.belongs_to :likeable, polymorphic: true
      t.timestamps
    end
  end
end
