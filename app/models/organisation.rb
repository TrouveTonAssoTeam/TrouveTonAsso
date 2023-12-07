class Organisation < ApplicationRecord
    # Devise modules
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
  
    # Validations
    validates :name, :description, :city, :website, presence: true
    
    has_many :donations
end
