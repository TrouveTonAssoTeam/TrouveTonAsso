class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :association, foreign_key: true
      belong_yo :likeable, polymorphic: true
      t.timestamps
    end
  end
end
