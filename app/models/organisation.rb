class Organisation < ApplicationRecord
    # Devise modules
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
  
    # Validations
    # validates :name, :description, :city, :address, :zip, presence: true
    
    has_many :donations
    has_one :cagnotte
    has_one :cagnotte_status

    after_create :create_cagnotte

    def create_cagnotte
    create_cagnotte(amount: 0) if cagnotte.nil?
    end
end
