class Organisation < ApplicationRecord
    # Devise modules
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
  
    # Validations
    # validates :name, :description, :city, :address, :zip, presence: true
    
    has_many :donations
    has_many :promoteds
end
