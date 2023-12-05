class Association < ApplicationRecord
    has_one :association_profile, foreign_key: 'association_reference'
    # Devise modules
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
  
    # Validations
    validates :name, :description, :city, :website, presence: true
  
end
