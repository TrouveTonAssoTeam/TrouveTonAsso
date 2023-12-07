class AddStripeIdToDonations < ActiveRecord::Migration[7.1]
  def change
    add_column :donations, :stripe_id, :string
  end
end
