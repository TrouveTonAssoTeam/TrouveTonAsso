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

user = User.create!(
  email: 'test2@user.com',
  password: 'password',
)

organisation = Organisation.create!(
  email: 'test@asso.com',
  password: 'password',
  name: 'Test Asso',
  description: 'Description',
  city: 'Ville',
  website: 'https://example.com'
)

organisation = Organisation.create!(
  email: 'test2@asso.com',
  password: 'password',
  name: 'Test Asso 2',
  description: 'Description',
  city: 'Ville',
  website: 'https://example.com'
)
