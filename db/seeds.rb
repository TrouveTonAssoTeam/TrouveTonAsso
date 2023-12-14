# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
user = User.create!(
  email: 'test@user.com',
  password: 'password',
  first_name: 'Patricia',
  last_name: 'Flamand',
)

user = User.create!(
  email: 'test@user2.com',
  password: 'password',
  first_name: 'Christian',
  last_name: 'Bonenfant',
)

organisation = Organisation.create!(
  email: 'test@asso.com',
  password: 'password',
  name: 'Test Asso',
  description: 'Description',
  address: '10 Rue de la Bombarde',
  city: 'Lyon',
  zip: '69005',
)

organisation = Organisation.create!(
  email: 'test@asso2.com',
  password: 'password',
  name: 'Test asso 2',
  description: 'Description',
  address: '5 Bd du Roi',
  city: 'Versailles',
  zip: '78000',
)
