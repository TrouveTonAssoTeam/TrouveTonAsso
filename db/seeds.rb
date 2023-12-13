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
)

organisation = Organisation.create!(
  email: 'test@asso.com',
  password: 'password',
  name: 'Test Asso',
  description: 'Description',
  city: 'Ville',
)

organisation = Organisation.create!(
  email: 'test@geocoder.com',
  password: 'password',
  name: 'Test gem Geocoder',
  description: 'Description',
  address: '10 Rue de la Bombarde',
  city: 'Lyon',
  zip: '69005'
)
