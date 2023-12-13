class CreateFaqs < ActiveRecord::Migration[7.1]
  def change
    create_table :faqs do |t|
      t.belongs_to :user
      t.belongs_to :organisation
      t.string :question
      t.string :answer

      t.timestamps
    end
  end
end
